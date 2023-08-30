//
//  ProductDetailsUserSection.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 27.08.2023.
//

import UIKit

final class ProductDetailsUserSection: UIView {
    
    private let userSectionTitle: UILabel = UILabel()
    private let locationLabel: UILabel = UILabel()
    private let emailLabel: UILabel = UILabel()
    private let phoneLabel: UILabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        addViews()
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(locationLabel)
        addSubview(userSectionTitle)
        addSubview(emailLabel)
        addSubview(phoneLabel)
    }
    
    func setupUserSection(location: String, email: String, phone: String, address: String) {
        locationLabel.text = "\(location), \(address)"
        emailLabel.text = email
        phoneLabel.text = phone
    }
    
    private func setupLabels() {
        userSectionTitle.text = Settings.sectionTitle
        userSectionTitle.font = .systemFont(ofSize: Settings.Fonts.large, weight: .bold)
        locationLabel.numberOfLines = 2
        locationLabel.font = .systemFont(ofSize: Settings.Fonts.small, weight: .regular)
        locationLabel.textColor = .gray
        emailLabel.font = .systemFont(ofSize: Settings.Fonts.small, weight: .regular)
        phoneLabel.font = .systemFont(ofSize: Settings.Fonts.small, weight: .regular)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        Settings.layout(
            size: size,
            userSectionTitle: userSectionTitle,
            locationLabel: locationLabel,
            emailLabel: emailLabel,
            phoneLabel: phoneLabel
        ).prefferedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = Settings.layout(
            size: bounds.size,
            userSectionTitle: userSectionTitle,
            locationLabel: locationLabel,
            emailLabel: emailLabel,
            phoneLabel: phoneLabel
        )
        
        userSectionTitle.frame = layout.userSectionTitleFrame
        emailLabel.frame = layout.emailLabelFrame
        phoneLabel.frame = layout.phoneLabelFrame
        locationLabel.frame = layout.locationLabelFrame
    }
}

fileprivate enum Settings {
    
    static let horizontalPadding: CGFloat = 15
    static let interItemSpacing: CGFloat = 4
    static let sectionTitle: String = "Пользователь"
    
    enum Fonts {
        static let small: CGFloat = 13
        static let large: CGFloat = 23
    }
    
    typealias Layout = (
        userSectionTitleFrame: CGRect,
        emailLabelFrame: CGRect,
        phoneLabelFrame: CGRect,
        locationLabelFrame: CGRect,
        prefferedSize: CGSize
    )
    
    static func layout(
        size: CGSize,
        userSectionTitle: UILabel,
        locationLabel: UILabel,
        emailLabel: UILabel,
        phoneLabel: UILabel
    ) -> Layout {
        let contentSize = CGSize(
            width: size.width,
            height: size.height
        )
        let userSectionTitleSize = userSectionTitle.sizeThatFits(contentSize)
        let userSectionTitleFrame = CGRect(
            x: horizontalPadding,
            y: .zero,
            width: userSectionTitleSize.width,
            height: userSectionTitleSize.height
        )

        let emailLabelSize = emailLabel.sizeThatFits(contentSize)
        let emailLabelFrame = CGRect(
            x: horizontalPadding,
            y: userSectionTitleFrame.maxY + interItemSpacing,
            width: emailLabelSize.width,
            height: emailLabelSize.height
        )

        let phoneLabelSize = phoneLabel.sizeThatFits(contentSize)
        let phoneLabelFrame = CGRect(
            x: horizontalPadding,
            y: emailLabelFrame.maxY + interItemSpacing,
            width: phoneLabelSize.width,
            height: phoneLabelSize.height
        )

        let locationLabelSize = locationLabel.sizeThatFits(contentSize)
        let locationLabelFrame = CGRect(
            x: horizontalPadding,
            y: phoneLabelFrame.maxY + interItemSpacing,
            width: locationLabelSize.width,
            height: locationLabelSize.height
        )
        
        let prefferedSize = CGSize(
            width: size.width,
            height: locationLabelFrame.maxY
        )
        return (
            userSectionTitleFrame,
            emailLabelFrame,
            phoneLabelFrame,
            locationLabelFrame,
            prefferedSize
        )
    }
    
}
