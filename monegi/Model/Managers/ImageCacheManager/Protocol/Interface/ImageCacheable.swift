//
//  ImageCacheable.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit

protocol ImageCacheable {
    static var shared: NSCache<NSString, UIImage> { get }
}
