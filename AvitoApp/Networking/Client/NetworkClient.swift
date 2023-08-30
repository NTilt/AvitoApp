//
//  NetworkClient.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 28.08.2023.
//

import Foundation

protocol NetworkClient: AnyObject {
    func send<Request: NetworkRequest>(
        request: Request
    ) async -> Result<Request.Response, NetworkError>
}

final class NetworkClientImpl: NetworkClient {
    
    private let session: URLSession = URLSession(configuration: .default)
    private let requestBuilder: RequestBuilder
    
    init(requestBuilder: RequestBuilder = RequestBuilderImpl()) {
        self.requestBuilder = requestBuilder
    }
    
    func send<Request: NetworkRequest>(
        request: Request
    ) async -> Result<Request.Response, NetworkError> {
        switch requestBuilder.build(request: request) {
        case .success(let urlRequest):
            return await send(
                urlRequest: urlRequest,
                responseConverter: request.responseConverter
            )
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func send<Converter: NetworkResponseConverter>(
        urlRequest: URLRequest,
        responseConverter: Converter
    ) async -> Result<Converter.Response, NetworkError> {
        do {
            let (data, _) = try await session.data(for: urlRequest)
            
            return decodeResponse(from: data, responseConverter: responseConverter)
        } catch {
            switch (error as? URLError)?.code {
            case .some(.notConnectedToInternet):
                return .failure(.noInternetConnection)
            case .some(.timedOut):
                return .failure(.timeout)
            default:
                return .failure(.networkError)
            }
        }
    }
    
    func decodeResponse<Converter: NetworkResponseConverter>(
        from data: Data,
        responseConverter: Converter
    ) -> Result<Converter.Response, NetworkError> {
        if let response = responseConverter.decodeResponse(from: data) {
            return .success(response)
        }
        return .failure(.parsingFailure)
    }
    
}
