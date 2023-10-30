//
//  HeaderField.swift
//  monegi
//
//  Created by Minseong Kang on 10/29/23.
//

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
            return "Bearer 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"
        case .version:
            return "2022-11-28"
        }
    }
}
