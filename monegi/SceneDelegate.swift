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
        
        let rootURLSession = URLSession(configuration: .default)
        let rootNetworkManager = NetworkManager(urlSession: rootURLSession)
        let rootNavigationController: UINavigationController = UINavigationController(rootViewController: SearchViewController(networkManager: rootNetworkManager))
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
}

