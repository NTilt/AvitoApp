//
//  ProductsResponse.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 28.08.2023.
//

import Foundation

struct ProductsResponse: Codable {
    let products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case products = "advertisements"
    }
}
