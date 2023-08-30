//
//  NetworkError.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 28.08.2023.
//

import Foundation

enum NetworkError: Error {
    case cantBuildUrlFromRequest
    case noInternetConnection
    case parsingFailure
    case networkError
    case timeout
}
