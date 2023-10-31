//
//  Color.swift
//  monegi
//
//  Created by Minseong Kang on 10/30/23.
//

import UIKit

enum Color {
    case white
    case clearShadow
    
    var uiColor: UIColor {
        switch self {
        case .white:
            return UIColor.white
        case .clearShadow:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        }
    }
    
    var cgColor: CGColor {
        switch self {
        case .white:
            return UIColor.white.cgColor
        case .clearShadow:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).cgColor
        }
    }
}
