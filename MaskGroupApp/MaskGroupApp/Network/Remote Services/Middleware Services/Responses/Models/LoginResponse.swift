//
//  LoginResponse.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 18/08/2023.
//

import Foundation

// MARK: - Welcome
public struct LoginResponse: Codable {
    public let message: String?
    public let statusCode: Int?
    public let data: DataClass?

    public init(message: String?, statusCode: Int?, data: DataClass?) {
        self.message = message
        self.statusCode = statusCode
        self.data = data
    }
}

// MARK: - DataClass
public struct DataClass: Codable {
    public let accessToken: String?
    public let expiresIn: Int?
    public let user: User?

    public init(accessToken: String?, expiresIn: Int?, user: User?) {
        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.user = user
    }
}

// MARK: - User
public struct User: Codable {
    public let email: String?
    public let id, phone: String?
    public let fullName: String?
    public let type: String?

    public init(email: String? = "" ,
                id: String? = "" ,
                phone: String? = "",
                fullName: String? = "",
                type: String? = "") {
        self.email = email
        self.id = id
        self.phone = phone
        self.fullName = fullName
        self.type = type
    }
}
