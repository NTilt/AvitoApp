//
//  PlaceholderProtocol.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 29.08.2023.
//

import Foundation

@MainActor
protocol PlaceholderProtocol: AnyObject {
    func showPlaceholder(model: Placeholder)
    func hidePlaceholder()
}

final class PlaceholderProtocolImpl: PlaceholderProtocol {
    
    private weak var placeholder: PlaceholderProtocol?
    
    init(placeholder: PlaceholderProtocol) {
        self.placeholder = placeholder
    }
    
    func showPlaceholder(model: Placeholder) {
        placeholder?.showPlaceholder(model: model)
    }
    
    func hidePlaceholder() {
        placeholder?.hidePlaceholder()
    }
    
}

extension PlaceholderProtocol {
    
    func showPlaceholder(error: NetworkError, onButtonTapped: @escaping () -> Void, onBackButtonTapped: (() -> Void)?) {
        
        switch error {
        case .noInternetConnection, .timeout:
            showPlaceholder(model: .init(
                labelTitle: "Нет интернета",
                image: "wifi.slash",
                button: Button(title: "Повторить", onTapped: { [weak self] in
                    self?.hidePlaceholder()
                    onButtonTapped()
                }),
                backButton: onBackButtonTapped == nil ? nil : BackButton(onTapped: {
                    onBackButtonTapped?()
                })
            ))
        default:
            showPlaceholder(model: .init(
                labelTitle: "Неизвестная ошибка",
                image: "arrow.clockwise.circle",
                button: Button(title: "Повторить", onTapped: { [weak self] in
                    self?.hidePlaceholder()
                    onButtonTapped()
                }),
                backButton: onBackButtonTapped == nil ? nil : BackButton(onTapped: {
                    onBackButtonTapped?()
                })
            ))
        }
    }
    
}
