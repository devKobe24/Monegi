//
//  MGItemInformationViewController.swift
//  monegi
//
//  Created by Minseong Kang on 11/1/23.
//

import UIKit

class MGItemInformationViewController: UIViewController {
    
    let stackView: UIStackView = UIStackView()
    let leftItemInfoView: MGItemInfoView = MGItemInfoView()
    let rightImteInfoView: MGItemInfoView = MGItemInfoView()
    let commonButton: MGButton = MGButton()
    
    var userData: User
    weak var delegate: UserInformationDelegate?
    
    init(userData: User) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundView()
        setupStackView()
        setupCommonButton()
    }
}

extension MGItemInformationViewController {
    
    private func setupBackgroundView() {
        let cornerRadius = (view.bounds.width) - (view.bounds.width - 18)
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(leftItemInfoView)
        stackView.addArrangedSubview(rightImteInfoView)
        
        configureStackView()
    }
    
    private func configureStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }
    
    private func setupCommonButton() {
        commonButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commonButton)
        
        commonButton.addTarget(self, action: #selector(didTapCommonButton), for: .touchUpInside)
        configureCommonButton()
    }
    
    @objc func didTapCommonButton() {}
    
    private func configureCommonButton() {
        NSLayoutConstraint.activate([
            commonButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            commonButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            commonButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            commonButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }
}
