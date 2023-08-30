//
//  SceneDelegate.swift
//  AvitoApp
//
//  Created by Никита Ясеник on 24.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        let viewController = ProductsScreenAssembly().viewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window = UIWindow(windowScene: scene)
        window?.overrideUserInterfaceStyle = .dark
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }


}

