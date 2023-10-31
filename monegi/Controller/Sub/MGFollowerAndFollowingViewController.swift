//
//  MGFollowerAndFollowingViewController.swift
//  monegi
//
//  Created by Minseong Kang on 11/1/23.
//

import UIKit

final class MGFollowerAndFollowingViewController: MGItemInformationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
    }
}

extension MGFollowerAndFollowingViewController {
    private func setupItems() {
        leftItemInfoView.set(itemInfoType: .followers, withCount: userData.followers)
        rightImteInfoView.set(itemInfoType: .following, withCount: userData.following)
        commonButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func didTapCommonButton() {
        delegate?.didTapGetFollowers(for: userData)
    }
}
