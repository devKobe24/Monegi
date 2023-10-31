//
//  MGContainerView.swift
//  monegi
//
//  Created by Minseong Kang on 10/30/23.
//

import UIKit

final class MGContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContainerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContainerView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = Color.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
