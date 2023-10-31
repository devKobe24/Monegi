//
//  Downlodable.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit

protocol Downlodable {
    func downloadImage(from urlString: String, completionHandler: @escaping (Result<UIImage, MGError>) -> Void)
}
