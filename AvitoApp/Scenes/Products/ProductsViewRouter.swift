//
//  ProductsViewRouter.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 25.08.2023.
//

import Foundation

protocol ProductsViewRouter {
    func presentDetailView(for product: Product)
}

class ProductsViewRouterImpl: ProductsViewRouter {
    fileprivate weak var productsViewController: ProductsViewController?
    fileprivate let scenesFactory: ScenesFactory
    fileprivate var product: Product?
    
    init(
        productsViewController: ProductsViewController,
        scenesFactory: ScenesFactory
    ) {
        self.productsViewController = productsViewController
        self.scenesFactory = scenesFactory
    }
    
    func presentDetailView(for product: Product) {
        self.product = product
        let detailsVC = scenesFactory.makeProductDetailScene(for: product)
        productsViewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
