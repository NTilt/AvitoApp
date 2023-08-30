//
//  ProductsService.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 28.08.2023.
//

import Foundation

protocol ProductsService: AnyObject {
    func getProducts() async -> Result<ProductsResponse, NetworkError>
}

final class ProductsServiceImpl: ProductsService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getProducts() async -> Result<ProductsResponse, NetworkError> {
        await networkClient.send(request: ProductsRequest())
    }
}
