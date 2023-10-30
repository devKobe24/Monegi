//
//  HeaderField.swift
//  monegi
//
//  Created by Minseong Kang on 10/29/23.
//

import Foundation

enum HeaderField {
    case accept
    case autorization
    case version
    
    var key: String {
        switch self {
        case .accept:
            return "Accept"
        case .autorization:
            return "Authorization"
        case .version:
            return "X-GitHub-Api-Version"
        }
    }
    
    var value: String {
        switch self {
        case .accept:
            return "application/vnd.github+json"
        case .autorization:
            return "Bearer \(Bundle.parsePlist(ofName: "STAGING-API-TOKEN"))"
        case .version:
            return "2022-11-28"
        }
    }
}
