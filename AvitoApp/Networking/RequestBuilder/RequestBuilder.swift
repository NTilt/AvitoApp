//
//  RequestBuilder.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 28.08.2023.
//

import Foundation

protocol RequestBuilder: AnyObject {
    func build(request: any NetworkRequest) -> Result<URLRequest, NetworkError>
}

final class RequestBuilderImpl: RequestBuilder {
    
    private let host: String
    
    init(host: String = "www.avito.st") {
        self.host = host
    }
    
    func build(request: any NetworkRequest) -> Result<URLRequest, NetworkError> {
        let urlString = "https://\(host)/\(request.path)"
        guard let url = URL(string: urlString) else {
            return .failure(.cantBuildUrlFromRequest)
        }
        var urlRequest = URLRequest(url: url, timeoutInterval: 10)
        urlRequest.httpMethod = request.httpMethod.rawValue
        return .success(urlRequest)
    }
    
}
