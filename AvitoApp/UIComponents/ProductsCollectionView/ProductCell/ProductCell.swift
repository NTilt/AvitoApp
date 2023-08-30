//
//  ProductCell.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 24.08.2023.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let image = UIImageView()
    private let priceLabel = UILabel()
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    
    var imageTask: URLSessionDataTask?
    
    private let loadIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.isHidden = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addViews()
        setup()
        setupImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
    
    private func addViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(image)
        contentView.addSubview(loadIndicator)
        contentView.addSubview(priceLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(dateLabel)
    }
    
    func showIndicator() {
        loadIndicator.isHidden = false
        loadIndicator.startAnimating()
    }
    
    func hideIndicator() {
        loadIndicator.stopAnimating()
        loadIndicator.isHidden = true
    }

    private func setupImage() {
        image.layer.cornerRadius = Settings.imageCornerRadius
        image.layer.masksToBounds = true
    }
    
    private func setup() {
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: Settings.Fonts.large)
        priceLabel.font = .systemFont(ofSize: Settings.Fonts.large, weight: .bold)
        locationLabel.font = .systemFont(ofSize: Settings.Fonts.small, weight: .semibold)
        locationLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: Settings.Fonts.small, weight: .semibold)
        dateLabel.textColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(image: UIImage?) {
        self.image.image = image
    }
    
    func configure(product: Product) {
        titleLabel.text = product.title
        priceLabel.text = product.price
        locationLabel.text = product.location
        dateLabel.text = product.createdDate
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        Settings.layout(
            size: size,
            titleLabel: titleLabel,
            image: image,
            priceLabel: priceLabel,
            locationLabel: locationLabel,
            dateLabel: dateLabel
        ).prefferedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = Settings.layout(
            size: bounds.size,
            titleLabel: titleLabel,
            image: image,
            priceLabel: priceLabel,
            locationLabel: locationLabel,
            dateLabel: dateLabel
        )
        
        titleLabel.frame = layout.titleLabelFrame
        image.frame = layout.imageFrame
        priceLabel.frame = layout.priceLabelFrame
        locationLabel.frame = layout.locationLabelFrame
        dateLabel.frame = layout.dateLabelFrame
        
        let indicatorSize = loadIndicator.sizeThatFits(bounds.size)
        loadIndicator.frame = CGRect(
            x: (image.frame.width - indicatorSize.width) / 2,
            y: (image.frame.height - indicatorSize.height) / 2,
            width: indicatorSize.width,
            height: indicatorSize.height
        )
    }
    
}

fileprivate enum Settings {
    
    static let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    static let interItemSpacing: CGFloat = 5
    static let imageCornerRadius: CGFloat = 5
    
    enum Fonts {
        static let small: CGFloat = 11
        static let large: CGFloat = 14
    }
    
    typealias Layout = (
        imageFrame: CGRect,
        titleLabelFrame: CGRect,
        priceLabelFrame: CGRect,
        locationLabelFrame: CGRect,
        dateLabelFrame: CGRect,
        prefferedSize: CGSize
    )
    
    static func layout(
        size: CGSize,
        titleLabel: UILabel,
        image: UIImageView,
        priceLabel: UILabel,
        locationLabel: UILabel,
        dateLabel: UILabel
    ) -> Layout {
        let contentSize = CGSize(
            width: size.width,
            height: size.height
        )
        
        let imageFrame = CGRect(
            x: contentInsets.left,
            y: contentInsets.top,
            width: size.width,
            height: size.width
        )
        
        let titleLabelSize = titleLabel.sizeThatFits(contentSize)
        let titleLabelFrame = CGRect(
            x: contentInsets.left,
            y: imageFrame.maxY + interItemSpacing,
            width: titleLabelSize.width,
            height: titleLabelSize.height
        )
        
        let priceLabelSize = priceLabel.sizeThatFits(contentSize)
        let priceLabelFrame = CGRect(
            x: contentInsets.left,
            y: titleLabelFrame.maxY + interItemSpacing,
            width: priceLabelSize.width,
            height: priceLabelSize.height
        )
        
        let locationLabelSize = locationLabel.sizeThatFits(contentSize)
        let locationLabelFrame = CGRect(
            x: contentInsets.left,
            y: priceLabelFrame.maxY + interItemSpacing,
            width: locationLabelSize.width,
            height: locationLabelSize.height
        )
        
        let dateLabelSize = dateLabel.sizeThatFits(contentSize)
        let dateLabelFrame = CGRect(
            x: contentInsets.left,
            y: locationLabelFrame.maxY + interItemSpacing,
            width: dateLabelSize.width,
            height: dateLabelSize.height
        )
        
        let prefferedSize = CGSize(
            width: size.width,
            height: dateLabelFrame.maxY + contentInsets.bottom
        )
        
        return (
            imageFrame,
            titleLabelFrame,
            priceLabelFrame,
            locationLabelFrame,
            dateLabelFrame,
            prefferedSize
        )
    }
    
}
