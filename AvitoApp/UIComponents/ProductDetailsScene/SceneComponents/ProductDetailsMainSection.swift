//
//  ProductDetailsMainSection.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 27.08.2023.
//

import UIKit

final class ProductDetailsMainSection: UIView {
    
    // MARK: Views
    private let image = UIImageView()
    private let backgroundImage = UIImageView()
    private let blurView = UIVisualEffectView()
    private let priceLabel = UILabel()
    private let titleLabel = UILabel()
    private let loadIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.isHidden = false
        return indicator
    }()
    
    init() {
        super.init(frame: .zero)
        
        addViews()
        loadIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(backgroundImage)
        addSubview(image)
        addSubview(priceLabel)
        addSubview(titleLabel)
        addSubview(loadIndicator)
    }
    
    func setImage(image: UIImage?) {
        if image != nil {
            loadIndicator.stopAnimating()
            backgroundImage.insertSubview(blurView, at: 0)
        }
        self.image.image = image
        self.backgroundImage.image = image
    }

    func setupMainSection(productPrice: String, productTitle: String) {
        image.contentMode = .scaleAspectFill
        
        let blurEffect = UIBlurEffect(style: .dark)
        blurView.effect = blurEffect
        
        priceLabel.text = productPrice
        priceLabel.font = .systemFont(ofSize: Settings.Fonts.large, weight: .bold)
        
        titleLabel.text = productTitle
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: Settings.Fonts.small, weight: .semibold)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        Settings.layout(
            size: size,
            image: image,
            backgroundImage: backgroundImage,
            priceLabel: priceLabel,
            titleLabel: titleLabel,
            loadIndicator: loadIndicator
        ).prefferedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = Settings.layout(
            size: bounds.size,
            image: image,
            backgroundImage: backgroundImage,
            priceLabel: priceLabel,
            titleLabel: titleLabel,
            loadIndicator: loadIndicator
        )
        
        image.frame = layout.imageFrame
        backgroundImage.frame = layout.backgroundImageFrame
        blurView.frame = layout.blurFrame
        priceLabel.frame = layout.priceLabelFrame
        titleLabel.frame = layout.titleLabelFrame
        loadIndicator.frame = layout.loadIndicatorFrame
    }
}

fileprivate enum Settings {
    
    static let horizontalPadding: CGFloat = 15
    static let interItemSpacing: CGFloat = 4
    
    enum Fonts {
        static let small: CGFloat = 16
        static let large: CGFloat = 27
    }
    
    typealias Layout = (
        imageFrame: CGRect,
        backgroundImageFrame: CGRect,
        blurFrame: CGRect,
        priceLabelFrame: CGRect,
        titleLabelFrame: CGRect,
        loadIndicatorFrame: CGRect,
        prefferedSize: CGSize
    )
    
    static func layout(
        size: CGSize,
        image: UIImageView,
        backgroundImage: UIImageView,
        priceLabel: UILabel,
        titleLabel: UILabel,
        loadIndicator: UIActivityIndicatorView
    ) -> Layout {
        let contentSize = CGSize(
            width: size.width,
            height: size.height
        )
        
        let imageFrame = CGRect(
            x: (contentSize.width - contentSize.width / 1.7) / 2,
            y: .zero,
            width: contentSize.width / 1.7,
            height: contentSize.width / 1.7
        )

        let backgroundImageFrame = CGRect(
            x: .zero,
            y: .zero,
            width: contentSize.width,
            height: imageFrame.height
        )

        let blurViewFrame = CGRect(
            x: .zero,
            y: .zero,
            width: backgroundImageFrame.width,
            height: backgroundImageFrame.height
        )

        let priceLabelSize = priceLabel.sizeThatFits(contentSize)
        let priceLabelFrame = CGRect(
            x: horizontalPadding,
            y: backgroundImageFrame.maxY + 2 * interItemSpacing,
            width: priceLabelSize.width,
            height: priceLabelSize.height
        )

        let titleLabelSize = titleLabel.sizeThatFits(contentSize)
        let titleLabelFrame = CGRect(
            x: horizontalPadding,
            y: priceLabelFrame.maxY + interItemSpacing,
            width: titleLabelSize.width,
            height: titleLabelSize.height
        )
        
        let loadIndicatorSize = loadIndicator.sizeThatFits(contentSize)
        let loadIndicatorFrame = CGRect(
            x: (backgroundImageFrame.width - loadIndicatorSize.width) / 2,
            y: (backgroundImageFrame.height - loadIndicatorSize.height) / 2,
            width: loadIndicatorSize.width,
            height: loadIndicatorSize.height
        )
        
        let prefferedSize = CGSize(
            width: contentSize.width,
            height: titleLabelFrame.maxY
        )
        
        return (
            imageFrame,
            backgroundImageFrame,
            blurViewFrame,
            priceLabelFrame,
            titleLabelFrame,
            loadIndicatorFrame,
            prefferedSize
        )
    }
    
}
