//
//  ProductsScreenAssembly.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 24.08.2023.
//

import UIKit

@MainActor
final class ProductsScreenAssembly {
    
    func viewController() -> UIViewController {
        let productViewController = ProductsViewController()
        
        let router = ProductsViewRouterImpl(
            productsViewController: productViewController,
            scenesFactory: ScenesFactoryImpl()
        )
        let service = ProductsServiceImpl(networkClient: NetworkClientImpl())
        let loader = LoaderProtocolImpl(loader: productViewController)
        let placeholder = PlaceholderProtocolImpl(placeholder: productViewController)
        
        let presenter = ProductsPresenter(
            router: router,
            service: service,
            loader: loader,
            placeholder: placeholder
        )
        presenter.productView = productViewController
        productViewController.addLink(link: presenter)
        return productViewController
    }
    
}
