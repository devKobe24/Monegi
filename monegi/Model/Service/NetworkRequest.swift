//
//  NetworkRequest.swift
//  monegi
//
//  Created by Minseong Kang on 10/29/23.
//

import Foundation

struct NetworkRequest {
    let url: String
    let headers: [String: String]?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: HttpMethod
    
    init(url: String,
         headers: [String : String]? = nil,
         body: Data? = nil,
         requestTimeOut: Float? = nil,
         httpMethod: HttpMethod
    ) {
        self.url = url
        self.headers = headers
        self.body = body
        self.requestTimeOut = requestTimeOut
        self.httpMethod = httpMethod
    }
    
    func buildURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.localized
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        
        return urlRequest
    }
}
