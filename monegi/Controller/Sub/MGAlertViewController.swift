//
//  MGAlertViewController.swift
//  monegi
//
//  Created by Minseong Kang on 10/30/23.
//

import UIKit

final class MGAlertViewController: UIViewController {
    
    private let containerView: MGContainerView = {
        let view = MGContainerView()
        
        return view
    }()
    
    private let titleLabel: MGTitleLabel = {
        let label = MGTitleLabel(textAlignment: .center,
                                 fontSize: 20)
        
        return label
    }()
    
    private let messageLabel: MGBodyLabel = {
        let label = MGBodyLabel(textAlignment: .center)
        
        return label
    }()
    
    private let confirmButton: MGButton = {
        let button = MGButton(backgroundColor: .systemPink,
                             title: "OK")
        
        return button
    }()
    
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    
    init(alertTitle: String?,
         message: String?,
         buttonTitle: String?) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        setupContainerView()
        setupTitleLabel()
        setupConfirmButton()
        setupMessageLabel()
    }
    
    private func initialSetup() {
        view.backgroundColor = Color.clearShadow.uiColor
    }
}

extension MGAlertViewController {
    
    private func setupContainerView() {
        view.addSubview(containerView)
        
        configureContainerViewUI()
    }
    
    private func configureContainerViewUI() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),
            containerView.widthAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 3.3/3)
        ])
    }
    
    private func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? MGError.alertTitle.errorDescription
        
        configureTitleLabelUI()
    }
    
    private func configureTitleLabelUI() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/5)
        ])
    }
    
    private func setupConfirmButton() {
        containerView.addSubview(confirmButton)
        confirmButton.setTitle(buttonTitle ?? MGError.buttonTitle.errorDescription,
                               for: .normal)
        confirmButton.addTarget(self, 
                                action: #selector(dismissViewController),
                                for: .touchUpInside)
        
        configureConfirmButtonUI()
    }
    
    private func configureConfirmButtonUI() {
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            confirmButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/5)
        ])
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func setupMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? MGError.message.errorDescription
        messageLabel.numberOfLines = 4
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        configureMessageLabelUI()
    }
    
    private func configureMessageLabelUI() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            messageLabel.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -12)
        ])
    }
}
