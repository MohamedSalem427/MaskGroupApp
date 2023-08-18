//
//  MoyaError+Extension.swift
//  Shift
//
//  Created by ziad on 3/26/20.
//  Copyright © 2020 generation-c. All rights reserved.
//

import Moya
import Foundation

 extension MoyaError {
    
    var toMiddlewareError: MiddlewareError {
        switch self {
        case .jsonMapping(let response):
            return .parsingResponse(message: "Mapping JSON Error: \(response.description)")
        case .imageMapping(let response):
            return .parsingResponse(message: "Mapping Image Error: \(response.description)")
        case .stringMapping(let response):
            return .parsingResponse(message: "Mapping String Error: \(response.description)")
        case .objectMapping( _ , let response):
            return .parsingResponse(message: "Mapping Object Error: \(response.description)")
        case .encodableMapping(let error):
            return .parsingResponse(message: "Encodable couldn’t be encoded into Data: \(error.localizedDescription)")
        case .requestMapping(let url):
            return .badRequest(message: "Endpoint failed to map to a URLRequest: \(url)")
        case .parameterEncoding(let error):
            return .parsingResponse(message: "parameter couldn’t be encoded into Data: \(error.localizedDescription)")
        case .statusCode(let response):
            guard let code = HTTPStatusCode(rawValue: response.statusCode) else {
                return .unknown(message: "\(response.statusCode) Endpoint failed to encode "
                    + "the parameters for the URLRequest: \(response.description)")
            }
            
            switch code {
            case .connectionClosedWithoutResponse:
                return .internet
            case .requestTimeout, .networkConnectTimeoutError:
                return .timedout
            case .unauthorized:
                return .authentication
            case .internalServerError, .notImplemented, .badGateway, .serviceUnavailable, .gatewayTimeout,
                 .httpVersionNotSupported, .variantAlsoNegotiates, .insufficientStorage, .loopDetected,
                 .notExtended, .networkAuthenticationRequired:
                return .server(localizedDescription)
            case .notModified:
                return .notModified
            default:
                return .httpCode(response.statusCode)
            }
            
        case let .underlying(error, _):
            guard let alError = error.asAFError else {
                return (error as NSError).toMiddlewareError
            }
            return alError.toMiddlewareError
        }
    }
}

