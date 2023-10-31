//
//  NetworkManageable.swift
//  monegi
//
//  Created by Minseong Kang on 10/29/23.
//

protocol NetworkManageable {
    func fetchListRepositoryData(
        owner: String,
        repo: String,
        completionHandler: @escaping(
            Result<[ListRepositoryActivities],
            MGError>) -> Void
    )
    
    func fetchListPublicRepositoryData(
        username: String,
        completionHandler: @escaping(
            Result<[ListRepositoiesForUser],
            MGError>) -> Void
    )
    
    func getUserInfo(
        username: String,
        completionHandler: @escaping(
            Result<User,
            MGError>) -> Void
    )
    
    func getFollower(
        username: String,
        perPage: Int,
        page: Int,
        completionHandler: @escaping(
            Result<[Follower],
            MGError>) -> Void
    )
}
