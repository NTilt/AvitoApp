//
//  NetworkResponseConverter.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 28.08.2023.
//

import Foundation

protocol NetworkResponseConverter: AnyObject {
    associatedtype Response
    
    func decodeResponse(from data: Data) -> Response?
}

final class NetworkResponseConverterImpl<Response: Decodable>: NetworkResponseConverter {
    
    func decodeResponse(from data: Data) -> Response? {
        return try? JSONDecoder().decode(Response.self, from: data)
    }
}

final class NetworkResponseConverterOf<Response>: NetworkResponseConverter {

    private let decodeResponse: (Data) -> Response?
    
    init<Converter: NetworkResponseConverter>(
        converter: Converter
    ) where Converter.Response == Response {
        decodeResponse = { data in
            converter.decodeResponse(from: data)
        }
    }
    
    func decodeResponse(from data: Data) -> Response? {
        decodeResponse(data)
    }
}
