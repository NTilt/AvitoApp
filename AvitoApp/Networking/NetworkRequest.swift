//
//  NetworkRequest.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 28.08.2023.
//

import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype Response
    
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var responseConverter: NetworkResponseConverterOf<Response> { get }
}

extension NetworkRequest where Response: Decodable {
    var responseConverter: NetworkResponseConverterOf<Response> {
        NetworkResponseConverterOf(converter: NetworkResponseConverterImpl())
    }
}
