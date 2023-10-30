//
//  ImageContents.swift
//  monegi
//
//  Created by Minseong Kang on 10/30/23.
//

import Foundation

enum ImageContents {
    case mgLogo
    
    var asset: String {
        switch self {
        case .mgLogo:
            return "monegi-logo"
        }
    }
}
