//
//  DownloadImageManager.swift
//  monegi
//
//  Created by Minseong Kang on 10/31/23.
//

import UIKit
import OSLog

struct DownloadImageManager: Downlodable {
    let urlSession: URLSession = URLSession.shared
    let logger: Logger = Logger()
}

extension DownloadImageManager {
    func downloadImage(from urlString: String, completionHandler: @escaping (Result<UIImage, MGError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.invalidRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidServer))
                return
            }
            
            let successStatusCodeRange = (200...299)
            
            if #available(iOS 16.0, *) {
                guard successStatusCodeRange.contains(response.statusCode) else {
                    logger.debug("\(response.statusCode) Error")
                    completionHandler(.failure(.invalidResponse))
                    return
                }
            } else {
                guard successStatusCodeRange ~= response.statusCode else {
                    logger.debug("\(response.statusCode) Error")
                    completionHandler(.failure(.invalidResponse))
                    return
                }
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            let cacheKey = NSString(string: urlString)
            
            if let cacheImage = ImageCacheManager.shared.object(forKey: cacheKey) {
                completionHandler(.success(cacheImage))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            ImageCacheManager.shared.setObject(image, forKey: cacheKey)
            completionHandler(.success(image))
        }
        dataTask.resume()
    }
}
