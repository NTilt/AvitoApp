//
//  ProductsCollectionView.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 24.08.2023.
//

import UIKit


final class ProductCollectionView: UIView {
    
    // MARK: CallBacks
    var didSelectProduct: ((Product) -> ())?
    var onTopRefresh: (() -> ())?
    
    // MARK: Model
    var products: [Product] = []
    
    private lazy var productsCollectionView: UICollectionView = {
        
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: Settings.verticalPadding, left: Settings.horizontalPadding, bottom: 0, right: Settings.horizontalPadding)
        layout.minimumInteritemSpacing = Settings.horizontalPadding
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "\(ProductCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        refreshControl.addTarget(self, action: #selector(topRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        addSubview(collectionView)
        return collectionView
    }()
    private let refreshControl = UIRefreshControl()
    
    func display(products: [Product]) {
        self.products = products
        productsCollectionView.reloadData()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    @objc private func topRefresh() {
        onTopRefresh?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        productsCollectionView.frame = bounds
    }
}

extension ProductCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ProductCell.self)", for: indexPath) as? ProductCell else {
             return UICollectionViewCell()
        }
        let product = products[indexPath.row]
        cell.configure(product: product)
        cell.showIndicator()
        cell.imageTask?.cancel()
        if let checkerImageUrl = URL(string: product.imageURL) {
            cell.imageTask = ImageLoader.shared.loadImage(withURL: checkerImageUrl, completion: { image in
                cell.setImage(image: image)
                cell.hideIndicator()
            })
        }
        return cell
    }
}

extension ProductCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        didSelectProduct?(product)
    }
}

extension ProductCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = ProductCell()
        cell.configure(product: products[indexPath.row])
        let size = CGSize(width: (bounds.width - 3 * Settings.horizontalPadding) / 2, height: (bounds.height - 3 * Settings.horizontalPadding) / 2)
        let cellSize = cell.sizeThatFits(size)
        return CGSize(width: cellSize.width, height: cellSize.height)
    }
}

fileprivate enum Settings {
    static let horizontalPadding: CGFloat = 15
    static let verticalPadding: CGFloat = 20
}
