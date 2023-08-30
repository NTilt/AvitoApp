//
//  ProductDetailsViewRouter.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 28.08.2023.
//

import Foundation

protocol ProductDetailsViewRouter {
    func dismiss()
}

class ProductDetailsViewRouterImpl: ProductDetailsViewRouter {
    fileprivate weak var productDetailsViewController: ProductDetailsViewController?
    
    init(productDetailsViewController: ProductDetailsViewController) {
        self.productDetailsViewController = productDetailsViewController
    }
    
    func dismiss() {
        productDetailsViewController?.navigationController?.popViewController(animated: true)
    }
    
}
