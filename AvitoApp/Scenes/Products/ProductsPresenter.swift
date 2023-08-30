//
//  ProductsPresenter.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 25.08.2023.
//

import Foundation
import UIKit

@MainActor
protocol ProductsView: AnyObject {
    var onViewDidLoad: (() -> ())? { get set }
    var onTopRefresh: (() -> ())? { get set }
    var didSelectProduct: ((Product) -> ())? { get set }
    func display(products: [Product])
    func endRefreshing()
}

final class ProductsPresenter {
    
    @MainActor
    weak var productView: ProductsView? {
        didSet {
            setupView()
        }
    }
    
    private let router: ProductsViewRouter
    private let service: ProductsService
    private let loader: LoaderProtocol
    private let placeholder: PlaceholderProtocol
    
    init(
        router: ProductsViewRouter,
        service: ProductsService,
        loader: LoaderProtocol,
        placeholder: PlaceholderProtocol
    ) {
        self.router = router
        self.service = service
        self.loader = loader
        self.placeholder = placeholder
    }
    
    @MainActor
    private func setupView() {
        
        productView?.onViewDidLoad = {[weak self]  in
            self?.loadProducts()
        }
        
        productView?.onTopRefresh = { [weak self] in
            self?.loadProducts(isRefreshing: true)
        }
        
        productView?.didSelectProduct = { [weak self] product in
            self?.router.presentDetailView(for: product)
        }
    }
    
    private func loadProducts(isRefreshing: Bool = false) {
        Task {
            await loadProducts(isRefreshing: isRefreshing)
        }
    }
    
    private func loadProducts(isRefreshing: Bool = false) async {
        let loader = isRefreshing ? nil : loader
        await loader?.showLoaderView()
        let results = await service.getProducts()
        await loader?.hideLoaderView()
        await productView?.endRefreshing()
        switch results {
        case .success(let productResponse):
            await convertProductResponse(response: productResponse)
        case .failure(let error):
            await convertProductResponseWithError(with: error)
        }
    }
    
    private func convertProductResponseWithError(with error: NetworkError) async {
        await placeholder.showPlaceholder(error: error, onButtonTapped: { [weak self] in
            self?.loadProducts()
        }, onBackButtonTapped: nil)
    }
    
    private func convertProductResponse(response: ProductsResponse) async {
        await productView?.display(products: response.products)
    }
    
}


