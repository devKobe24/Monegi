//
//  URLSessionable.swift
//  monegi
//
//  Created by Minseong Kang on 10/29/23.
//

import Foundation

typealias DataTaskCompletionHandler = @Sendable (Data?, URLResponse?, Error?) -> Void

protocol URLSessionable {
    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask
}

