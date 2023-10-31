//
//  MGSecondaryTitleLabel.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit

final class MGSecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        
        configureMGSecondaryTitleLabel()
    }
    
    private func configureMGSecondaryTitleLabel() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
