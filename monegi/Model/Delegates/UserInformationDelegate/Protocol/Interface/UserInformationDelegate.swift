//
//  UserInformationDelegate.swift
//  monegi
//
//  Created by Minseong Kang on 11/1/23.
//

protocol UserInformationDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}
