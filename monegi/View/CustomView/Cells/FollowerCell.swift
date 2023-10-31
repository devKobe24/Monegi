//
//  FollowerCell.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit

final class FollowerCell: UICollectionViewCell, Reusable {
    var avatarImageView: MGAvatarImageView = MGAvatarImageView(frame: .zero)
    
    let usernameLabel: MGTitleLabel = MGTitleLabel(
        textAlignment: .center,
        fontSize: 16
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAvatarImageView()
        setupUsernameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FollowerCell {
    func setup(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
}

extension FollowerCell {
    private func setupAvatarImageView() {
        guard let placeHolderImage = UIImage(named: Image(image: .mgAvatarPlaceHolder).image.asset) else {
            return
        }
        
        self.avatarImageView.set(placeHolderImage: placeHolderImage)
        
        contentView.addSubview(avatarImageView)
        
        configureAvatarImageView()
    }
    
    private func configureAvatarImageView() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func setupUsernameLabel() {
        contentView.addSubview(usernameLabel)
        configureUsernameLabel()
    }
    
    private func configureUsernameLabel() {
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.widthAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1),
            usernameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
        ])
    }
}
