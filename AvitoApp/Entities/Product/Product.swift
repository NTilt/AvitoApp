//
//  Product.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 25.08.2023.
//

import Foundation

struct Product: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageURL: String
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}


