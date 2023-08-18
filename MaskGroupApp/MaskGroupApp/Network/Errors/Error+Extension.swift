//
//  Error+Extension.swift
//  Shift
//
//  Created by ziad on 3/26/20.
//  Copyright © 2020 generation-c. All rights reserved.
//

import Foundation

 extension Error {
    var toMiddlewareError: MiddlewareError {
        let nsError = self as NSError
        return nsError.toMiddlewareError
    }
}
 extension NSError {
    var toMiddlewareError: MiddlewareError {
        let code =  URLError.Code(rawValue: self.code)
        switch code {
        case .notConnectedToInternet, .networkConnectionLost:
            return .internet
        case .timedOut:
            return .timedout
        case .cannotFindHost:
            return .connection
        case .cannotConnectToHost:
            return .server(localizedDescription)
        case .userAuthenticationRequired:
            return .authentication
        case .badServerResponse, .cannotParseResponse, .cannotDecodeRawData, .cannotDecodeContentData:
            return .parsingResponse(message: "\(code): \(localizedDescription)")
        case .badURL, .unsupportedURL:
            return .badRequest(message: "\(code): Endpoint failed to encode the parameters for the URLRequest: \(localizedDescription)")
        default:
            return .underlying(code: code.rawValue, message: "\(code): \(localizedDescription)")
        }
    }
}
