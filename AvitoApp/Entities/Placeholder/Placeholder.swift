//
//  Placeholder.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 29.08.2023.
//

import Foundation

struct Placeholder {
    let labelTitle: String
    let image: String
    let button: Button
    let backButton: BackButton?
}

struct BackButton {
    let onTapped: () -> Void
}

struct Button {
    let title: String
    let onTapped: () -> Void
}
