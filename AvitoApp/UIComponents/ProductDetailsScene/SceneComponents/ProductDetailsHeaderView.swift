//
//  ProductDetailsHeaderView.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 27.08.2023.
//

import UIKit

final class ProductDetailsHeaderView: UIView {
    
    private let backButton: UIButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        
        addViews()
        setupBackButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(backButton)
    }
    
    private func setupBackButton() {
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(nil, action: #selector(ProductDetailsViewController.dismissView), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backButton.frame = CGRect(
            x: Settings.horizontalPadding,
            y: .zero,
            width: bounds.height,
            height: bounds.height
        )
    }
}

fileprivate enum Settings {
    static let horizontalPadding: CGFloat = 15
}
