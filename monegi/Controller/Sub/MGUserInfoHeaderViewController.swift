//
//  MGUserInfoHeaderViewController.swift
//  monegi
//
//  Created by Minseong Kang on 11/1/23.
//

import UIKit

final class MGUserInfoHeaderViewController: UIViewController {
    
    let avatarImageView: MGAvatarImageView = MGAvatarImageView(frame: .zero)
    let usernameLabel: MGTitleLabel = MGTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel: MGSecondaryTitleLabel = MGSecondaryTitleLabel(fontSize: 18)
    let locationImageView: UIImageView = UIImageView()
    let locationLabel: MGSecondaryTitleLabel = MGSecondaryTitleLabel(fontSize: 20)
    let bioLabel: MGBodyLabel = MGBodyLabel(textAlignment: .left)
    
    var userData: User
    
    
    init(userData: User) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAvatarImageView()
        setupUsernameLabel()
        setupLocationImageView()
        setupLocationLabel()
        setupBioLabel()
    }
}

extension MGUserInfoHeaderViewController {
    
    private func setupAvatarImageView() {
        avatarImageView.downloadImage(from: userData.avatarUrl)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImageView)
        
        configureAvatarImageView()
    }
    
    private func configureAvatarImageView() {
        let width: CGFloat = (view.bounds.width) - (view.bounds.width - 90)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: width),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func setupUsernameLabel() {
        usernameLabel.text = userData.login
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameLabel)
        configureUsernameLabel()
    }
    
    private func configureUsernameLabel() {
        let height: CGFloat = (view.bounds.height) - (view.bounds.height - 38)
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func setupLocationImageView() {
        guard let locationImage = UIImage(systemName: Image(image: .sfMappinAndEllipse).image.asset) else { return }
        locationImageView.image = locationImage
        locationImageView.tintColor = .secondaryLabel
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationImageView)
        configureLocationImageView()
    }
    
    private func configureLocationImageView() {
        let width: CGFloat = (view.bounds.width) - (view.bounds.width - 20)
        
        NSLayoutConstraint.activate([
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            locationImageView.widthAnchor.constraint(equalToConstant: width),
            locationImageView.heightAnchor.constraint(equalTo: locationImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func setupLocationLabel() {
        locationLabel.text = userData.location ?? "N/A"
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationLabel)
        
        configureLocationLabel()
    }
    
    private func configureLocationLabel() {
        let height = (view.bounds.height) - (view.bounds.height - 20)
        
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func setupBioLabel() {
        bioLabel.numberOfLines = 3
        bioLabel.text = userData.bio ?? "N/A"
        
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bioLabel)
        
        configureBioLabel()
    }
    
    private func configureBioLabel() {
        let height = (view.bounds.height) - (view.bounds.height - 60)
        
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
