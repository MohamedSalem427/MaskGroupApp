//
//  BreedsEndPoints.swift
//  CodersList
//
//  Created by Mohamed Salem on 23/03/2022.
//

import Foundation
import Moya

enum UserEndPoint {
    case login(otp: String, phone: String)
    case otpCustomer(phone: String)
    case availableServices
    
}

extension UserEndPoint: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        .bearer
    }
    
    var baseURL: URL { AppEnvironment.baseURL }
    var path: String {
        switch self {
        case .login: return "auth/login/customer"
        case .otpCustomer: return "auth/otp/customer"
        case .availableServices: return "services/available"
        }
    }
    var method: Moya.Method {
        switch self {
        case .availableServices: return .get
        default: return .post
        }
    }
    
    var sampleData: Data { Data() }
    // reason_code
    var parameters: [String: Any] {
        switch self {
        case let.login(otp, phone):
            return ["otp": otp, "phone": phone]
        case let.otpCustomer(phone):
            return ["phone": phone]
        case .availableServices: return [:]
        }
    }
    
    var task: Task {
        switch self {
        case .login,.otpCustomer:
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .availableServices :
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        [HTTPHeaderField.contentType.rawValue : ContentType.json.rawValue,
         HTTPHeaderField.acceptType.rawValue : ContentType.applicationJson.rawValue]
    }
}

enum AppEnvironment {
    static var baseURL: URL {
        URL(string: "https://maghassel-api.barsha.io/api/v1/")!
    }

}
