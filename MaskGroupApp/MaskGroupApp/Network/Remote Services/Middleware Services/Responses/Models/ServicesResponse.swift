//
//  ServicesResponse.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 18/08/2023.
//

import Foundation

public struct ServicesResponse: Codable {
    public let statusCode: Int?
    public let message: String?
    public let data: [ServiceDatum]?

    public init(statusCode: Int?,
                message: String?,
                data: [ServiceDatum]?) {
        self.statusCode = statusCode
        self.message = message
        self.data = data
    }
}

public struct ServiceDatum: Codable {
    public let id, name, createdAt, updatedAt: String?
    public let image: ServiceImage?

    public init(id: String?, name: String?, createdAt: String?, updatedAt: String?, image: ServiceImage?) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.image = image
    }
}
public struct ServiceImage: Codable {
    public let id, mimetype, filename, imageExtension: String?
    public let size: Int?
    public let protectedURL, publicURL, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, mimetype, filename
        case imageExtension = "extension"
        case size
        case protectedURL = "protected_url"
        case publicURL = "public_url"
        case createdAt, updatedAt
    }

    public init(id: String?, mimetype: String?, filename: String?, imageExtension: String?, size: Int?, protectedURL: String?, publicURL: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.mimetype = mimetype
        self.filename = filename
        self.imageExtension = imageExtension
        self.size = size
        self.protectedURL = protectedURL
        self.publicURL = publicURL
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
