//
//  Follower.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
