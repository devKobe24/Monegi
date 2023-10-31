//
//  SceneDelegate.swift
//  monegi
//
//  Created by Minseong Kang on 10/29/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootNetworkManager = NetworkManager()
        
        let searchNavigationController = UINavigationController().createNavigationController(
            with: SearchViewController(networkManager: rootNetworkManager),
            title: "Search",
            tabBarItemImage: Image(image: .search),
            tag: 0
        )
        let monegiNavigationController = UINavigationController().createNavigationController(
            with: MyMonegiViewController(),
            title: "Monegi",
            tabBarItemImage: Image(image: .monegi),
            tag: 1
        )
        
        let rootTabBarController = UITabBarController().createTabBarController(
            tintColor: .systemGreen,
            viewControllers: [
                searchNavigationController,
                monegiNavigationController
            ]
        )
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootTabBarController
        window?.makeKeyAndVisible()
    }
}

