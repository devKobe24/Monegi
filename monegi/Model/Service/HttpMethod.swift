//
//  HttpMethod.swift
//  monegi
//
//  Created by Minseong Kang on 10/29/23.
//

import Foundation

enum HttpMethod {
    case GET
    case POST
    case PUT
    case DELETE
    
    var localized: String {
        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        case .PUT:
            return "PUT"
        case .DELETE:
            return "DELETE"
        }
    }
}
