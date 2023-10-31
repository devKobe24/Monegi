//
//  MGTextField.swift
//  monegi
//
//  Created by Minseong Kang on 10/30/23.
//

import UIKit

final class MGTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextField() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.secondaryLabel.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemGroupedBackground
        returnKeyType = .go
        autocorrectionType = .no
        
        placeholder = "Enter a username"
    }
}


