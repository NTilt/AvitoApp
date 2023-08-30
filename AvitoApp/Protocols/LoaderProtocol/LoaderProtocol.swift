//
//  LoaderProtocol.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 29.08.2023.
//

import Foundation

@MainActor
protocol LoaderProtocol: AnyObject {
    func showLoaderView()
    func hideLoaderView()
}

final class LoaderProtocolImpl: LoaderProtocol {
    
    private weak var loader: LoaderProtocol?
    
    init(loader: LoaderProtocol) {
        self.loader = loader
    }
    
    func showLoaderView() {
        loader?.showLoaderView()
    }
    
    func hideLoaderView() {
        loader?.hideLoaderView()
    }
    
}
