//
//  LoaderView.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 29.08.2023.
//

import Foundation
import UIKit

final class LoaderView: UIView {
    
    private let loadIndicator = UIActivityIndicatorView(style: .large)
    
    init() {
        super.init(frame: .zero)
        
        addSubview(loadIndicator)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = Settings.backgroundColor
    }
    
    func start() {
        loadIndicator.startAnimating()
    }
    
    func stop() {
        loadIndicator.stopAnimating()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let loaderSize = loadIndicator.sizeThatFits(bounds.size)
        loadIndicator.frame = CGRect(
            x: (bounds.width - loaderSize.width) / 2,
            y: (bounds.height - loaderSize.height) / 2,
            width: loaderSize.width,
            height: loaderSize.height
        )
    }
}

fileprivate enum Settings {
    static let backgroundColor: UIColor = .black
}
