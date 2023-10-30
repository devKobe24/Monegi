//
//  MGError.swift
//  monegi
//
//  Created by Minseong Kang on 10/29/23.
//

import Foundation

enum MGError: LocalizedError {
    case invalidResponse
    case invalidServer
    case invalidRequest
    case invalidHeader
    case fetchListRepository
    case fetchListPublicRepository
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "잘못된 응답입니다."
        case .invalidServer:
            return "잘못된 서버 응답입니다."
        case .invalidRequest:
            return "잘못된 URL 요청입니다."
        case .invalidHeader:
            return "잘못된 Header 요청입니다."
        case .fetchListRepository:
            return "List Repository Activities 데이터를 가져오지 못했습니다..."
        case .fetchListPublicRepository:
            return "List Public Repository 데이터를 가져오지 못했습니다..."
        }
    }
}
