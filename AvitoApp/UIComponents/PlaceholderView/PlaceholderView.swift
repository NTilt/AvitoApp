//
//  PlaceholderView.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 29.08.2023.
//

import Foundation
import UIKit

final class PlaceholderView: UIView {
    
    typealias onButtonTapped = () -> Void
    typealias onBackButtonTapped = () -> Void
    
    //MARK: Callbacks
    private var onButtonTapped: onButtonTapped?
    private var onBackButtonTapped: onBackButtonTapped?
    
    // MARK : Views
    private let imageView = UIImageView()
    private let label = UILabel()
    private let button = UIButton()
    private let backButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        
        addViews()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(button)
        addSubview(backButton)
        addSubview(label)
        addSubview(imageView)
    }
    
    private func setupViews() {
        
        imageView.tintColor = Settings.imageColor
    
        label.textColor = Settings.titleTextColor
        label.font = Settings.titleFont
        
        button.backgroundColor = Settings.Button.backgroundColor
        button.layer.cornerRadius = Settings.Button.cornerRadius
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        backgroundColor = Settings.backgroundColor
        
        backButton.tintColor = Settings.BackButton.tintColor
        backButton.setImage(Settings.BackButton.image, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func update(data: Placeholder) {
        label.text = data.labelTitle
        imageView.image = UIImage(systemName: data.image)
        let attributedTitle = NSAttributedString(string: data.button.title, attributes: Settings.Button.attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        self.onButtonTapped = {
            data.button.onTapped()
        }
        self.onBackButtonTapped = {
            data.backButton?.onTapped()
        }
        backButton.isHidden = data.backButton == nil ? true: false
        setNeedsLayout()
    }
    
    @objc private func backButtonTapped() {
        self.onBackButtonTapped?()
    }
    
    @objc private func buttonTapped() {
        self.onButtonTapped?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageViewSize = imageView.sizeThatFits(bounds.size)
        imageView.frame = CGRect(
            x: (bounds.width - imageViewSize.width * 3) / 2,
            y: (bounds.height - imageViewSize.height * 3) / 2,
            width: imageViewSize.width * 3,
            height: imageViewSize.height * 3
        )
        
        let labelSize = label.sizeThatFits(bounds.size)
        label.frame = CGRect(
            x: (bounds.width - labelSize.width) / 2,
            y: imageView.frame.maxY + Settings.interItemSpacing,
            width: labelSize.width,
            height: labelSize.height
        )
        
        let buttonSize = button.sizeThatFits(bounds.size)
        let buttonWidth = buttonSize.width + 2 * Settings.Button.horizontalPadding
        let buttonHeight = buttonSize.height + 2 * Settings.Button.verticalPadding
        button.frame = CGRect(
            x: (bounds.width - buttonWidth) / 2,
            y: label.frame.maxY + Settings.interItemSpacing,
            width: buttonWidth,
            height: buttonHeight
        )
        
        backButton.frame = CGRect(
            x: Settings.BackButton.horizontalPadding,
            y: Settings.BackButton.verticalPadding,
            width: Settings.BackButton.buttonSize.width,
            height: Settings.BackButton.buttonSize.height
        )
    }
    
}

fileprivate enum Settings {
    
    static let backgroundColor: UIColor = .black
    static let interItemSpacing: CGFloat = 10
    static let titleFont: UIFont = .systemFont(ofSize: 13, weight: .regular)
    static let titleTextColor: UIColor = .white
    static let imageColor: UIColor = .white
    
    enum Button {
        
        static let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        static let horizontalPadding: CGFloat = 15
        static let verticalPadding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let backgroundColor: UIColor = .white
    }
    
    enum BackButton {
        
        static let image = UIImage(systemName: "arrow.backward")
        static let tintColor: UIColor = .white
        static let horizontalPadding: CGFloat = 15
        static let verticalPadding: CGFloat = 50
        static let buttonSize: CGSize = CGSize(width: 50, height: 50)
        
    }
    
}
