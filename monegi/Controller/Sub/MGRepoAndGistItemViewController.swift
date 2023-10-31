//
//  MGRepoAndGistItemViewController.swift
//  monegi
//
//  Created by Minseong Kang on 11/1/23.
//

import UIKit

final class MGRepoAndGistItemViewController: MGItemInformationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
    }
}

extension MGRepoAndGistItemViewController {
    
    private func setupItems() {
        leftItemInfoView.set(itemInfoType: .repos, withCount: userData.publicRepos)
        rightImteInfoView.set(itemInfoType: .gists, withCount: userData.publicGists)
        commonButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func didTapCommonButton() {
        delegate?.didTapGithubProfile(for: userData)
    }
}
