//
//  UINavigationController+.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit

extension UINavigationController {
    func createNavigationController(
        with viewController: UIViewController,
        title: String,
        tabBarItemImage: Image,
        tag: Int
    ) -> UINavigationController {
        viewController.title = title
        
        guard let tabBarItemImage = UIImage(named: tabBarItemImage.image.asset) else {
            fatalError("Asset Image를 찾을 수 없습니다.")
        }
        
        viewController.tabBarItem = UITabBarItem(
            title: title,
            image: tabBarItemImage,
            tag: tag
        )
        
        return UINavigationController(rootViewController: viewController)
    }
}
