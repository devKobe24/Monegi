//
//  ImageContents.swift
//  monegi
//
//  Created by Minseong Kang on 10/30/23.
//

import Foundation

struct Image {
    
    var image: ImageContents
    
    enum ImageContents {
        case mgLogo
        case search
        case monegi
        case mgAvatarPlaceHolder
        case mgEmptyStateLogo
        case sfFolder
        case sfTextAlignleft
        case sfHeart
        case sfPersonTwo
        case sfMappinAndEllipse
        
        var asset: String {
            switch self {
            case .mgLogo:
                return "monegi-logo"
            case .search:
                return "magnifyingglass"
            case .monegi:
                return "archivebox"
            case .mgAvatarPlaceHolder:
                return "avatar-placeholder"
            case .mgEmptyStateLogo:
                return "empty-state-logo"
            case .sfFolder:
                return "folder"
            case .sfTextAlignleft:
                return "text.alignleft"
            case .sfHeart:
                return "heart"
            case .sfPersonTwo:
                return "person.2"
            case .sfMappinAndEllipse:
                return "mappin.and.ellipse"
            }
        }
    }
    
    init(image: ImageContents) {
        self.image = image
    }
}
