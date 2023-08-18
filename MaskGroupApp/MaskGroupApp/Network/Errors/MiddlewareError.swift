//
//  CustomError.swift
//  Shift
//
//  Created by ziad on 3/26/20.
//  Copyright © 2020 generation-c. All rights reserved.
//

import Foundation

//MARK:- MiddlewareError
 enum MiddlewareError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    
    case internet
    case connection
    case timedout
    
    case authentication
    
    case notModified

    case server(String)
    
    case parsingResponse(message:String)

    case badRequest(message:String)
    case underlying(code:Int, message: String)
    case database(message: String)
    case unknown(message: String)
    
    case business(error:Error?, message:String)

}

extension MiddlewareError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "🥴 Invalid URL"
        case let .httpCode(code): return "🤬 Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "🤯 Unexpected response from the server"
            
        case .internet:
            return "😹 No Connection To Internet"
        case .connection:
            return "🗣 connection"
        case .timedout:
            return "😹 timedout"
        case .authentication:
            return "☠️ authentication"
        case .notModified:
            return " notModified"
        case let .server(message):
            return message
        case .badRequest(let message):
            return message
        case .underlying(_, let message):
            return message
        case .database(let message):
            return message
        case .unknown(let message):
            return message
        case .business(_, let message):
            return message
        case .parsingResponse(let message):
            return message
        }
    }
}

