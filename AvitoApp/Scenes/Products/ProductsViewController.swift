//
//  ProductsViewController.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 24.08.2023.
//

import UIKit

final class ProductsViewController:
    UIViewController,
    ProductsView,
    PlaceholderProtocol,
    LoaderProtocol
{
    
    private let placeholderView = PlaceholderView()
    private let loaderView = LoaderView()
    private let collectionView = ProductCollectionView()
    private var link: Any?
    
    // MARK: CallBacks
    var onTopRefresh: (() -> ())? {
        get { collectionView.onTopRefresh }
        set { collectionView.onTopRefresh = newValue }
    }
    var onViewDidLoad: (() -> ())?

    var didSelectProduct: ((Product) -> ())? {
        get { collectionView.didSelectProduct }
        set { collectionView.didSelectProduct = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad?()
        self.title = Settings.title
        addViews()
    }
    
    private func addViews() {
        view.addSubview(placeholderView)
        view.addSubview(loaderView)
        view.addSubview(collectionView)
    }
    
    func showPlaceholder(model: Placeholder) {
        placeholderView.update(data: model)
        placeholderView.isHidden = false
        view.bringSubviewToFront(placeholderView)
    }
    
    func hidePlaceholder() {
        placeholderView.isHidden = true
        view.sendSubviewToBack(placeholderView)
    }
    
    func addLink(link: Any?) {
        self.link = link
    }
    
    func endRefreshing() {
        collectionView.endRefreshing()
    }
    
    func display(products: [Product]) {
        collectionView.display(products: products)
    }
    
    func showLoaderView() {
        loaderView.isHidden = false
        loaderView.start()
        view.bringSubviewToFront(loaderView)
    }
    
    func hideLoaderView() {
        loaderView.isHidden = true
        loaderView.stop()
        view.sendSubviewToBack(loaderView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.frame = view.bounds
        loaderView.frame = view.bounds
        placeholderView.frame = view.bounds
    }
}

fileprivate enum Settings {
        
    static let title: String = "Рекомендации"
    
}
