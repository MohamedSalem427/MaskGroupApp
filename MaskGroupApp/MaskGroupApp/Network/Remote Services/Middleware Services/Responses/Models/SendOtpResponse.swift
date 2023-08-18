//
//  SendOtpResponse.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 18/08/2023.
//

import Foundation
public struct SendOtpResponse: Codable {
    public let statusCode: Int?
    public let message,
               timestamp,
               path: String?

    public init(statusCode: Int? = 0,
                message: String? = "",
                timestamp: String? = "",
                path: String? = "") {
        self.statusCode = statusCode
        self.message = message
        self.timestamp = timestamp
        self.path = path
    }
}
