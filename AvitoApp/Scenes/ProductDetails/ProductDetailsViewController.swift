//
//  ProductDetailsViewController.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 27.08.2023.
//

import UIKit

final class ProductDetailsViewController:
    UIViewController,
    PlaceholderProtocol,
    LoaderProtocol,
    ProductDetailsViewProtocol
{
    
    //MARK: CallBacks
    var onViewDidLoad: (() -> ())?
    var viewDismiss: (() -> ())?
    var imageNeedLoad: ((String) -> Void)? {
        get { detailsView.imageNeedLoad }
        set { detailsView.imageNeedLoad = newValue }
    }
    
    private let product: Product
    private var link: Any?
    var productId: String {
        product.id
    }
    
    // MARK: Views
    private let placeholderView = PlaceholderView()
    private let loaderView = LoaderView()
    private let detailsView = ProductDetailsView()
    
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad?()
        view.addSubview(loaderView)
        view.addSubview(placeholderView)
        view.addSubview(detailsView)
    }
    
    func addLink(link: Any?) {
        self.link = link
    }
    
    func setImage(image: UIImage?) {
        detailsView.setupImage(image: image)
    }
    
    func display(details: ProductDetails) {
        detailsView.setup(productDetails: details)
    }
    
    @objc func dismissView() {
        viewDismiss?()
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
    
    func showPlaceholder(model: Placeholder) {
        placeholderView.update(data: model)
        placeholderView.isHidden = false
        view.bringSubviewToFront(placeholderView)
    }
    
    func hidePlaceholder() {
        placeholderView.isHidden = true
        view.sendSubviewToBack(placeholderView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        detailsView.frame = view.bounds
        loaderView.frame = view.bounds
        placeholderView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
