//
//  ProductDetailsDescriptionSection.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 27.08.2023.
//

import UIKit

final class ProductDetailsDescriptionSection: UIView {
    
    private let descriptionSectionTitle: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        addViews()
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(descriptionSectionTitle)
        addSubview(descriptionLabel)
    }
    
    func setupDescriptionSection(description: String) {
        descriptionLabel.text = description
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = .systemFont(ofSize: Settings.Fonts.small, weight: .regular)
    }
    
    private func setupLabels() {
        descriptionSectionTitle.text = Settings.sectionTitle
        descriptionSectionTitle.font = .systemFont(ofSize: Settings.Fonts.large, weight: .bold)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = Settings.layout(
            size: bounds.size,
            descriptionSectionTitle: descriptionSectionTitle,
            descriptionLabel: descriptionLabel
        )
        
        descriptionSectionTitle.frame = layout.descriptionSectionTitleFrame
        descriptionLabel.frame = layout.descriptionLabelFrame
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        Settings.layout(
            size: size,
            descriptionSectionTitle: descriptionSectionTitle,
            descriptionLabel: descriptionLabel
        ).prefferedSize
    }
}

fileprivate enum Settings {
    
    static let horizontalPadding: CGFloat = 15
    static let iterItemSpacing: CGFloat = 4
    static let sectionTitle: String = "Описание"
    
    enum Fonts {
        static let small: CGFloat = 16
        static let large: CGFloat = 23
    }
    
    typealias Layout = (
        descriptionSectionTitleFrame: CGRect,
        descriptionLabelFrame: CGRect,
        prefferedSize: CGSize
    )
    
    static func layout(
        size: CGSize,
        descriptionSectionTitle: UILabel,
        descriptionLabel: UILabel
    ) -> Layout {
        let contentSize = CGSize(
            width: size.width,
            height: size.height
        )
        
        let descriptionSectionTitleSize = descriptionSectionTitle.sizeThatFits(contentSize)
        let descriptionSectionTitleFrame = CGRect(
            x: horizontalPadding,
            y: .zero,
            width: descriptionSectionTitleSize.width,
            height: descriptionSectionTitleSize.height
        )
        
        let descriptionLabelSize = descriptionLabel.sizeThatFits(contentSize)
        let descriptionLabelFrame = CGRect(
            x: horizontalPadding,
            y: descriptionSectionTitleFrame.maxY + iterItemSpacing,
            width: descriptionLabelSize.width,
            height: descriptionLabelSize.height
        )
        
        let prefferedSize = CGSize(
            width: contentSize.width,
            height: descriptionLabelFrame.maxY
        )
        
        return (
            descriptionSectionTitleFrame,
            descriptionLabelFrame,
            prefferedSize
        )
    }
    
}
