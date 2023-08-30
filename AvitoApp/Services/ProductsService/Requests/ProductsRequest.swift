//
//  ProductsRequest.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 28.08.2023.
//

import Foundation

final class ProductsRequest: NetworkRequest {
    typealias Response = ProductsResponse
    
    let path = "s/interns-ios/main-page.json"
    let httpMethod: HttpMethod = .GET
}
