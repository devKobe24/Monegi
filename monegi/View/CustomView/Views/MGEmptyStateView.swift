//
//  MGEmptyStateView.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit

final class MGEmptyStateView: UIView {
    
    let messageLabel: MGTitleLabel = MGTitleLabel(
        textAlignment: .center,
        fontSize: 28
    )
    
    let logoImageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMessageLabel()
        setupLogoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        
        setupMessageLabel()
        setupLogoImageView()
    }
}

extension MGEmptyStateView {
    private func setupMessageLabel() {
        addSubview(messageLabel)
        
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        configureMessageLabel()
    }
    
    private func configureMessageLabel() {
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/5)
        ])
    }
    
    private func setupLogoImageView() {
        addSubview(logoImageView)
        logoImageView.image = UIImage(named: Image(image: .mgEmptyStateLogo).image.asset)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        configureLogoImageView()
    }
    
    private func configureLogoImageView() {
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 200),
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 200)
        ])
    }
}
