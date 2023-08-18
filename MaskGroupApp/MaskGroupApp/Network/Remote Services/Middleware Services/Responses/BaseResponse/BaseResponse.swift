//
//  BookingResponse.swift
//  Shift
//
//  Created by ziad on 3/31/20.
//  Copyright © 2020 generation-c. All rights reserved.
//

import Foundation
final class BaseResponse<T: Codable>: Codable{
    private var code: HTTPCode?
    var message: String = ""
    var statusCode: HTTPStatusCode?
    var result: T?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case result
        case statusCode
    }
    
    init(from decoder: Decoder)  throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decodeIfPresent(Int.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
        statusCode = HTTPStatusCode(rawValue: code ?? 0)
        result = try container.decodeIfPresent(T.self, forKey: .result)
    }
}




