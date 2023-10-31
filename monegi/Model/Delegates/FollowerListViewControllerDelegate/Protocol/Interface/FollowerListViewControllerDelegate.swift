//
//  FollowerListViewControllerDelegate.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

protocol FollowerListViewControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}
