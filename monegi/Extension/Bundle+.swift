//
//  Bundle+.swift
//  monegi
//
//  Created by Minseong Kang on 10/30/23.
//

import Foundation
import OSLog

fileprivate let logger = Logger()

extension Bundle {
    
    static func parsePlist(ofName name: String) -> [String: AnyObject] {
        guard let plistUrl = Bundle.main.url(forResource: name, withExtension: "plist") else {
            logger.debug("💔 \(name).plist 파일을 찾을 수 없습니다")
            fatalError("💔 \(name).plist 파일을 찾을 수 없습니다.")
        }
        
        guard let plistData = try? Data(contentsOf: plistUrl),
              let plistDictionary = try? PropertyListSerialization.propertyList(from: plistData, format: nil) as? [String: AnyObject] else {
            logger.debug("💔 딕셔너리 데이터를 읽어올 수 없습니다")
            fatalError("💔 딕셔너리 데이터를 읽어올 수 없습니다")
        }
        
        return plistDictionary
    }
}
