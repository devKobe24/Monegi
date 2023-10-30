//
//  APIEnviorment.swift
//  monegi
//
//  Created by Minseong Kang on 10/30/23.
//

import Foundation

enum APIEnviorment: String, CaseIterable {
    case development
    case staging
    case production
}

extension APIEnviorment {
    var githubServiceBaseUrl: String {
        switch self {
        case .development:
            return "https://dev-api.github.com"
        case .staging:
            return "https://stg-api.github.com"
        case .production:
            return "https://api.github.com"
        }
    }
}
