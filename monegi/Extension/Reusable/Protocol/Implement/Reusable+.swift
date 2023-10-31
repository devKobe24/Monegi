//
//  Reusable+.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit

extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
