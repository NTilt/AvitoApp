//
//  ProductDetailsRequest.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 29.08.2023.
//

import Foundation

final class ProductDetailsRequest: NetworkRequest {
    typealias Response = ProductDetailsResponse
    
    let id: String
    let path: String
    let httpMethod: HttpMethod = .GET
    
    init(id: String) {
        self.id = id
        self.path = "s/interns-ios/details/\(id).json"
    }

}
