//
//  MGItemInfoView.swift
//  monegi
//
//  Created by Minseong Kang on 11/1/23.
//

import UIKit

final class MGItemInfoView: UIView {
    
    let symbolImageView: UIImageView = UIImageView()
    let titleLabel: MGTitleLabel = MGTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel: MGTitleLabel = MGTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSymbolImageView()
        setupTitleLabel()
        setupCountLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MGItemInfoView {
    
    private func setupSymbolImageView() {
        
        symbolImageView.contentMode = .scaleAspectFit
        symbolImageView.tintColor = .label
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(symbolImageView)
        
        configureSymbolImageView()
    }
    
    private func configureSymbolImageView() {
        
        let width = (self.bounds.width) - (self.bounds.width - 20)
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: width),
            symbolImageView.heightAnchor.constraint(equalTo: symbolImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func setupTitleLabel() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        configureTitleLabel()
    }
    
    private func configureTitleLabel() {
        
        let height = (self.bounds.height) - (self.bounds.height - 10)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func setupCountLabel() {
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(countLabel)
        
        configureCountLabel()
    }
    
    private func configureCountLabel() {
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 1)
        ])
    }
}

extension MGItemInfoView {
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        
        switch itemInfoType {
        case .repos:
            guard let reposImage = UIImage(systemName: Image(image: .sfFolder).image.asset) else { return }
            symbolImageView.image = reposImage
            titleLabel.text = "Public Repos"
            countLabel.text = String(count)
        case .gists:
            guard let gistImage = UIImage(systemName: Image(image: .sfTextAlignleft).image.asset) else { return }
            symbolImageView.image = gistImage
            titleLabel.text = "Public Gists"
            countLabel.text = String(count)
        case .followers:
            guard let followersImage = UIImage(systemName: Image(image: .sfHeart).image.asset) else { return }
            symbolImageView.image = followersImage
            titleLabel.text = "Followers"
            countLabel.text = String(count)
        case .following:
            guard let followingImage = UIImage(systemName: Image(image: .sfPersonTwo).image.asset) else { return }
            symbolImageView.image = followingImage
            titleLabel.text = "Following"
            countLabel.text = String(count)
        }
    }
}
