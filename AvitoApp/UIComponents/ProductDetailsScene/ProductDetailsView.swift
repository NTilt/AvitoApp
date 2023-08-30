//
//  ProductDetailsView.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 27.08.2023.
//

import UIKit
import Combine

final class ProductDetailsView: UIView {
    
    // MARK: CallBacks
    var imageNeedLoad: ((String) -> Void)?
    
    // MARK: Sections
    private let headerView = ProductDetailsHeaderView()
    private let mainSection = ProductDetailsMainSection()
    private let userSection = ProductDetailsUserSection()
    private let descriptionSection = ProductDetailsDescriptionSection()
    
    // MARK: Footer Section
    private let createdDateLabel: UILabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        addViews()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .black
    }
    
    private func addViews() {
        addSubview(headerView)
        addSubview(mainSection)
        addSubview(userSection)
        addSubview(descriptionSection)
        addSubview(createdDateLabel)
    }
    
    func setupImage(image: UIImage?) {
        mainSection.setImage(image: image)
    }
    
    func setup(productDetails: ProductDetails) {
        mainSection.setupMainSection(
            productPrice: productDetails.price,
            productTitle: productDetails.title
        )
        imageNeedLoad?(productDetails.imageURL)
        userSection.setupUserSection(
            location: productDetails.location,
            email: productDetails.email,
            phone: productDetails.phoneNumber,
            address: productDetails.address
        )
        descriptionSection.setupDescriptionSection(
            description: productDetails.description
        )
        setupFooterSection(createdDate: productDetails.createdDate)
        
        setNeedsLayout()
    }
    
    private func setupFooterSection(createdDate: String) {
        createdDateLabel.text = "Объявление создано: \(createdDate)"
        createdDateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        createdDateLabel.textColor = .gray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = Settings.layout(
            size: bounds.size,
            window: window,
            headerSection: headerView,
            mainSection: mainSection,
            userSection: userSection,
            descriptionSection: descriptionSection,
            footerSection: createdDateLabel
        )
        
        headerView.frame = layout.headerSectionFrame
        mainSection.frame = layout.mainSectionFrame
        userSection.frame = layout.userSectionFrame
        descriptionSection.frame = layout.descriptionSectionFrame
        createdDateLabel.frame = layout.footerSection
    }
}

fileprivate enum Settings {
    
    static let iterSectionSpacing: CGFloat = 20
    static let horizontalPadding: CGFloat = 15
    
    typealias Layout = (
        headerSectionFrame: CGRect,
        mainSectionFrame: CGRect,
        userSectionFrame: CGRect,
        descriptionSectionFrame: CGRect,
        footerSection: CGRect
    )
    
    static func layout(
        size: CGSize,
        window: UIWindow?,
        headerSection: UIView,
        mainSection: UIView,
        userSection: UIView,
        descriptionSection: UIView,
        footerSection: UIView
    ) -> Layout {
        let contentSize = CGSize(
            width: size.width,
            height: size.height
        )
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
        let headerViewFrame = CGRect(
            x: .zero,
            y: statusBarHeight,
            width: contentSize.width,
            height: 50
        )
        
        let mainSectionSize = mainSection.sizeThatFits(contentSize)
        let mainSectionFrame = CGRect(
            x: .zero,
            y: headerViewFrame.maxY,
            width: mainSectionSize.width,
            height: mainSectionSize.height
        )
        
        let userSectionSize = userSection.sizeThatFits(contentSize)
        let userSectionFrame = CGRect(
            x: .zero,
            y: mainSectionFrame.maxY + iterSectionSpacing,
            width: userSectionSize.width,
            height: userSectionSize.height
        )
        
        let descriptionSectionSize = descriptionSection.sizeThatFits(contentSize)
        let descriptionSectionFrame = CGRect(
            x: .zero,
            y: userSectionFrame.maxY + iterSectionSpacing,
            width: descriptionSectionSize.width,
            height: descriptionSectionSize.height
        )
        
        let footerSectionSize = footerSection.sizeThatFits(contentSize)
        let footerSectionFrame = CGRect(
            x: horizontalPadding,
            y: descriptionSectionFrame.maxY + iterSectionSpacing,
            width: footerSectionSize.width,
            height: footerSectionSize.height
        )
        
        return (
            headerViewFrame,
            mainSectionFrame,
            userSectionFrame,
            descriptionSectionFrame,
            footerSectionFrame
        )
    }
}
