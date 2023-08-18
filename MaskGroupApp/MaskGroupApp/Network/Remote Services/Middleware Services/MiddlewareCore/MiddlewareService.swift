//
//  MiddlewareService.swift
//  Shift
//
//  Created by ziad on 3/26/20.
//  Copyright © 2020 generation-c. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import Combine

protocol MiddlewareProtocol {
    associatedtype T where T: TargetType & AccessTokenAuthorizable
    func request<R: Codable>(target: T) -> AnyPublisher<R, MiddlewareError>
}

class IBGSessionManager: Alamofire.Session {
    static let sharedManager: IBGSessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        let manager = IBGSessionManager(configuration: configuration)
        return manager
    }()
}

class MiddlewareService<T: TargetType & AccessTokenAuthorizable>: MiddlewareProtocol {

    // MARK: - Attributes
    let provider: MoyaProvider<T> = {
        let endpointClosure = { (target: T) -> Endpoint in
            var defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: target.authentications)
            var request = try? defaultEndpoint.urlRequest()
            request?.cachePolicy = .useProtocolCachePolicy
            request?.log()
            return defaultEndpoint
        }
        
        if let host = AppEnvironment.baseURL.host {
            let pinningCert = PinnedCertificatesTrustEvaluator()
            let trustManager = ServerTrustManager(allHostsMustBeEvaluated: false,
                                                  evaluators: [host: DisabledTrustEvaluator()])
            let session = Session(serverTrustManager: trustManager)
            return MoyaProvider<T>(
                endpointClosure: endpointClosure,
                session: session,
                plugins: [logger])
        }
        return MoyaProvider<T>(
            endpointClosure: endpointClosure,
            session: IBGSessionManager.sharedManager,
            plugins: [logger])
    }()


    //MARK: - Methods
     func request<R: Codable>(target: T) -> AnyPublisher<R,MiddlewareError> {
         let passSubject = PassthroughSubject<R,MiddlewareError>()
         provider.request(target) {
             if let response = try? $0.get() {
                 _ = "\(response.request?.httpMethod ?? "") \(response.request?.description ?? "")"
                 _ = response.data.toString()
             }
             switch $0 {
             case let .success(response):
                 do {
                     let decoder = JSONDecoder()
                     let result = try decoder.decode(R.self, from: response.data)
                     passSubject.send(result)
                 } catch {
                     passSubject.send(completion: .failure(error.toMiddlewareError))
                 }
             case let .failure(error):
                 passSubject.send(completion: .failure(error.toMiddlewareError))
             }
         }
         return passSubject.eraseToAnyPublisher()
     }

}
extension AccessTokenAuthorizable {
    var authentications: [String: String] {
        switch authorizationType {
        case .custom:
            return [:]
        case .none:
            return [:]
        case .basic: return [:]
        case .bearer:
            if let accessToken:String  = UserDefaults.standard.get(.accessToken) {
                return ["Authorization": "Bearer \(accessToken)"]
            }else {
                return [:]
            }
        }
    }
}
private var logger: NetworkLoggerPlugin {
    var config = NetworkLoggerPlugin.Configuration()
    // Log Options
    var logOptions = NetworkLoggerPlugin.Configuration.LogOptions()
    logOptions.insert(NetworkLoggerPlugin.Configuration.LogOptions.verbose)
    config.logOptions = logOptions
    // Formatter
    config.formatter = NetworkLoggerPlugin.Configuration.Formatter(responseData: jsonResponseDataFormatter)
    return NetworkLoggerPlugin(configuration: config)
}

private func jsonResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(decoding: prettyData, as: UTF8.self)
    } catch { return String(decoding: data, as: UTF8.self) }
}

public extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}


public extension URLRequest {
    func log() {
        print("""
            -----------------------------------------
            \(httpMethod ?? "") \(self)
            BODY \n \(httpBody?.toString() ?? "")
            HEADERS \n \(allHTTPHeaderFields ?? [:])
            -----------------------------------------
            """)
    }
}

public extension NSMutableURLRequest {
    func log() {
        print("""
            -----------------------------------------
            \(httpMethod ) \(self)
            BODY \n \(httpBody?.toString() ?? "")
            HEADERS \n \(allHTTPHeaderFields ?? [:])
            -----------------------------------------
            """)
    }
}
