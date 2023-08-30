//
//  ProductDetailsPresenter.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 29.08.2023.
//

import Foundation
import UIKit

@MainActor
protocol ProductDetailsViewProtocol: AnyObject {
    var productId: String { get }
    var onViewDidLoad: (() -> Void)? { get set }
    var viewDismiss: (() -> Void)? { get set }
    var imageNeedLoad: ((String) -> Void)? { get set }
    func display(details: ProductDetails)
    func setImage(image: UIImage?)
}

final class ProductDetailsPresenter {
    
    @MainActor
    weak var productDetails: ProductDetailsViewProtocol? {
        didSet {
            setupView()
        }
    }
    
    private let router: ProductDetailsViewRouter
    private let service: ProductDetailsService
    private let loader: LoaderProtocol
    private let placeholder: PlaceholderProtocol
    
    init(
        router: ProductDetailsViewRouter,
        service: ProductDetailsService,
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
        
        productDetails?.onViewDidLoad = { [weak self] in
            guard let productID = self?.productDetails?.productId else { return }
            self?.loadDetailsBy(by: productID)
        }
        
        productDetails?.viewDismiss = { [weak self] in
            self?.router.dismiss()
        }
        
        productDetails?.imageNeedLoad = { [weak self] imageURL in
            guard let checkedImageUrl = URL(string: imageURL) else { return }
            _ = ImageLoader.shared.loadImage(withURL: checkedImageUrl) { [weak self] image in
                self?.productDetails?.setImage(image: image)
            }
        }
    }
    
    private func loadDetailsBy(by id: String) {
        Task {
            await loadDetailsBy(by: id)
        }
    }
    
    private func loadDetailsBy(by id: String) async {
        await loader.showLoaderView()
        
        let results = await service.getDetailsById(by: id)
        await loader.hideLoaderView()
        switch results {
        case .success(let response):
            await convertProductDetailsResponse(response: response)
        case .failure(let error):
            await convertProductDetailsResponseWithError(with: error, id: id)
        }
    }
    
    private func convertProductDetailsResponseWithError(with error: NetworkError, id: String) async {
        await placeholder.showPlaceholder(error: error, onButtonTapped: { [weak self] in
            self?.loadDetailsBy(by: id)
        }, onBackButtonTapped: { [weak self] in
            self?.router.dismiss()
        })
    }
    
    @MainActor
    private func convertProductDetailsResponse(response: ProductDetailsResponse) {
        productDetails?.display(
            details: ProductDetails(
                id: response.id,
                title: response.title,
                price: response.price,
                location: response.location,
                imageURL: response.imageURL,
                createdDate: response.createdDate,
                description: response.description,
                email: response.email,
                phoneNumber: response.phoneNumber,
                address: response.address
            )
        )
    }
    
}
