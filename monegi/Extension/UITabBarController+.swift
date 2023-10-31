//
//  UITabBarController+.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit

extension UITabBarController {
    func createTabBarController(tintColor: UIColor,
                                viewControllers: [UIViewController]
    ) -> UITabBarController {
        UITabBar.appearance().tintColor = tintColor
        self.viewControllers = viewControllers
        
        return self
    }
}
