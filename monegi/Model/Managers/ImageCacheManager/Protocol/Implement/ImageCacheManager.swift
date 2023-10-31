//
//  ImageCacheManager.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit

final class ImageCacheManager: ImageCacheable {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
