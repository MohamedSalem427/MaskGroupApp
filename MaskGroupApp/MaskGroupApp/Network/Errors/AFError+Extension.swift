//
//  AFError+Extension.swift
//  Shift
//
//  Created by ziad on 4/9/20.
//  Copyright © 2020 generation-c. All rights reserved.
//

import Alamofire


 extension AFError {
    
    var toMiddlewareError: MiddlewareError {
        switch self {
            
        case let .createUploadableFailed(error),
             let .createURLRequestFailed(error),
             let .downloadedFileMoveFailed(error, _, _):
            return error.toMiddlewareError
            
        case .explicitlyCancelled:
            return .internet
        case .invalidURL:
            return .invalidURL
        case .multipartEncodingFailed:
            return .badRequest(message: "multipartEncodingFailed")
        case .parameterEncodingFailed:
            return .badRequest(message: "parameterEncodingFailed")
        case .parameterEncoderFailed:
            return .badRequest(message: "parameterEncoderFailed")
        case .requestAdaptationFailed:
            return .badRequest(message: "requestAdaptationFailed")
        case let .requestRetryFailed(retryError, _):
            return retryError.toMiddlewareError
        case .responseValidationFailed, .responseSerializationFailed:
            return .unexpectedResponse
        case .serverTrustEvaluationFailed:
            return .server(localizedDescription)
        case .sessionDeinitialized:
            return .unknown(message: "sessionDeinitialized")
        case .sessionInvalidated(let error):
            return error?.toMiddlewareError ?? .internet
        case .sessionTaskFailed:
            return .internet
        case .urlRequestValidationFailed:
            return .badRequest(message: "bodyDataIn GET Request")
        }
    }
}
