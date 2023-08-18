//
//  NetworkingEnums.swift
//  Shift
//
//  Created by ziad on 3/26/20.
//  Copyright © 2020 generation-c. All rights reserved.
//

import Foundation

enum HTTPHeaderField: String {
    
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case contentLanguage = "Content-Language"
    case apiKey = "api-key"
}

enum ContentType: String {
    
    case json = "application/json; charset=utf-8"
    case applicationJson = "application/json"
    case multipart = "multipart/form-data"
}
