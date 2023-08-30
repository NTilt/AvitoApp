//
//  ScenesFactory.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 27.08.2023.
//

import Foundation

protocol ScenesFactory {
    func makeProductDetailScene(for product: Product) -> ProductDetailsViewController
}

final class ScenesFactoryImpl: ScenesFactory {
    
    @MainActor
    func makeProductDetailScene(for product: Product) -> ProductDetailsViewController {
        let controller = ProductDetailsViewController(product: product)
        let router = ProductDetailsViewRouterImpl(productDetailsViewController: controller)
        let placeholder = PlaceholderProtocolImpl(placeholder: controller)
        let loader = LoaderProtocolImpl(loader: controller)
        let presenter = ProductDetailsPresenter(
            router: router,
            service: ProductDetailsServiceImpl(networkClient: NetworkClientImpl()),
            loader: loader,
            placeholder: placeholder
        )
        controller.addLink(link: presenter)
        presenter.productDetails = controller
        return controller
    }
    
}
