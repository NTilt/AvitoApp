//
//  ProductDetailsService.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 29.08.2023.
//

import Foundation

protocol ProductDetailsService {
    func getDetailsById(by id: String) async -> Result<ProductDetailsResponse, NetworkError>
}

final class ProductDetailsServiceImpl: ProductDetailsService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getDetailsById(
        by id: String
    ) async -> Result<ProductDetailsResponse, NetworkError> {
        await networkClient.send(request: ProductDetailsRequest(id: id))
    }
}
