//
//  GithubServiceEndPoint.swift
//  monegi
//
//  Created by Minseong Kang on 10/30/23.
//

import Foundation

enum GithubServiceEndPoint {
    case getListRepoData(owner: String, repo: String)
    case getListRepoForUser(username: String)
    case getUserInfo(username: String)
    case getFollower(username: String)
    
    func getURL(from environment: APIEnviorment) -> String {
        let baseUrl = environment.githubServiceBaseUrl
        
        switch self {
        case .getListRepoData(let owner, let repo):
            return "\(baseUrl)/repos/\(owner)/\(repo)/activity"
        case .getListRepoForUser(let username):
            return "\(baseUrl)/users/\(username)/repos"
        case .getUserInfo(let username):
            return "\(baseUrl)/users/\(username)"
        case .getFollower(username: let username):
            return "\(baseUrl)/users/\(username)/followers"
        }
    }
}
