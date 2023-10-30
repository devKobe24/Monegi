//
//  NetworkManageable.swift
//  monegi
//
//  Created by Minseong Kang on 10/29/23.
//

protocol NetworkManageable {
    func fetchListRepositoryData(owner: String,
                           repo: String,
                           completionHandler: @escaping(Result<[ListRepositoryActivities],
                                                        MGError>) -> Void)
    
    func fetchListPublicRepositoryData(username: String,
        completionHandler: @escaping(Result<[ListRepositoiesForUser],
                                     MGError>) -> Void)
}
