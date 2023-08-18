//
//  FakeData.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 03/08/2023.
//

import Foundation

import SwiftUI

struct ProductItems {
    let id: String
    let image: Image
    init(id: String, image: Image) {
        self.id = id
        self.image = image
    }
}

struct FakeProducts {
    static let items:[ProductItems] = [.init(id: "1", image: Image("Mask Group 3")),
                                       .init(id: "2", image: Image("Mask Group 3"))]
}

struct ServiceItems {
    let id: String
    let image: String
    let description: String
    init(id: String,
         image: String,
         description:String) {
        self.id = id
        self.image = image
        self.description = description
    }
}

struct FakeServices{
    static let items:[ServiceItems] = [.init(id: "1", image: "dollarsign.square.fill",description: "كوي"),
                                       .init(id: "2", image: "giftcard.fill" , description: "تنظيف"),
                                       .init(id: "3", image: "dollarsign.square.fill" , description: "دراي كلين"),
                                       .init(id: "4", image: "giftcard.fill",description: "غسيل")]
}
