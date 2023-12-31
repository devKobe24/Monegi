//
//  NetworkManager.swift
//  monegi
//
//  Created by Minseong Kang on 10/29/23.
//

import Foundation
import OSLog

struct NetworkManager: NetworkManageable {
    let urlSession: URLSession = URLSession.shared
    let logger: Logger = Logger()
}

extension NetworkManager {
    func fetchListRepositoryData(owner: String, repo: String, completionHandler: @escaping (Result<[ListRepositoryActivities], MGError>) -> Void) {
        
        let getListRepoEndpoint: GithubServiceEndPoint = .getListRepoData(owner: owner, repo: repo)
        let getListRepoDataUrl = getListRepoEndpoint.getURL(from: .production)
        guard var components = URLComponents(string: getListRepoDataUrl) else {
            return
        }
        
        // day, week, month, quarter, year 중 하나
        let timePeriod = URLQueryItem(name: "time_period", value: "day")
        components.queryItems = [
            timePeriod
        ]
        
        guard let url = components.url else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HttpMethod.GET.localized
            
            var headers: [String: String] = [:]
            headers[HeaderField.accept.key] = HeaderField.accept.value
            headers[HeaderField.autorization.key] = HeaderField.autorization.value
            headers[HeaderField.version.key] = HeaderField.version.value
            
            urlRequest.allHTTPHeaderFields = headers
            
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidServer))
                return
            }
            
            let successStatusRange = (200...299)
            
            guard successStatusRange ~= response.statusCode else {
                logger.debug("\(response.statusCode) Error")
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([ListRepositoryActivities].self, from: data)

                completionHandler(.success(decodedData))
            } catch {
                logger.debug("\(error.localizedDescription)")
                completionHandler(.failure(.fetchListRepository))
            }
        }
        dataTask.resume()
    }
}

extension NetworkManager {
    func fetchListPublicRepositoryData(username: String, completionHandler: @escaping (Result<[ListRepositoiesForUser], MGError>) -> Void) {
        
        let getListPublicRepoEndPoint: GithubServiceEndPoint = .getListRepoForUser(username: username)
        let getListPublicRepoDataUrl = getListPublicRepoEndPoint.getURL(from: .production)
        guard let components = URLComponents(string: getListPublicRepoDataUrl) else {
            return
        }
        
        guard let url = components.url else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HttpMethod.GET.localized
            
            var headers: [String: String] = [:]
            headers[HeaderField.accept.key] = HeaderField.accept.value
            headers[HeaderField.autorization.key] = HeaderField.autorization.value
            headers[HeaderField.version.key] = HeaderField.version.value
            
            urlRequest.allHTTPHeaderFields = headers
            
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidServer))
                return
            }
            
            let successStatusRange = (200...299)
            
            guard successStatusRange ~= response.statusCode else {
                logger.debug("\(response.statusCode) Error")
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([ListRepositoiesForUser].self, from: data)
                print(decodedData)
                completionHandler(.success(decodedData))
            } catch {
                print(error.localizedDescription)
                completionHandler(.failure(.fetchListPublicRepository))
            }
        }
        dataTask.resume()
    }
}

extension NetworkManager {
    func getUserInfo(username: String, completionHandler: @escaping (Result<User, MGError>) -> Void) {
        
        let getUserInfoEndPoint: GithubServiceEndPoint = .getUserInfo(username: username)
        let getUserInfoDataUrl = getUserInfoEndPoint.getURL(from: .production)
        guard let components = URLComponents(string: getUserInfoDataUrl) else {
            return
        }
        
        guard let url = components.url else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HttpMethod.GET.localized
            
            var headers: [String: String] = [:]
            headers[HeaderField.accept.key] = HeaderField.accept.value
            headers[HeaderField.autorization.key] = HeaderField.autorization.value
            headers[HeaderField.version.key] = HeaderField.version.value
            
            urlRequest.allHTTPHeaderFields = headers
            
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidServer))
                return
            }
            
            let successStatusRange = (200...299)
            
            guard successStatusRange ~= response.statusCode else {
                logger.debug("\(response.statusCode) Error")
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(User.self, from: data)
                print(decodedData)
                completionHandler(.success(decodedData))
            } catch {
                print(error.localizedDescription)
                completionHandler(.failure(.invalidServer))
            }
            
        }
        dataTask.resume()
    }
}

extension NetworkManager {
    func getFollower(username: String, perPage: Int, page: Int, completionHandler: @escaping (Result<[Follower], MGError>) -> Void) {
        let getFollowerEndPoint: GithubServiceEndPoint = .getFollower(username: username)
        let getFollowerDataUrl = getFollowerEndPoint.getURL(from: .production)
        guard let components = URLComponents(string: getFollowerDataUrl) else {
            return
        }
        
        guard let url = components.url else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HttpMethod.GET.localized
            
            var headers: [String: String] = [:]
            headers[HeaderField.accept.key] = HeaderField.accept.value
            headers[HeaderField.autorization.key] = HeaderField.autorization.value
            headers[HeaderField.version.key] = HeaderField.version.value
            
            urlRequest.allHTTPHeaderFields = headers
            
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidServer))
                return
            }
            
            let successStatusRange = (200...299)
            
            guard successStatusRange ~= response.statusCode else {
                logger.debug("\(response.statusCode) Error")
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Follower].self, from: data)
                print(decodedData)
                completionHandler(.success(decodedData))
            } catch {
                print(error.localizedDescription)
                completionHandler(.failure(.invalidServer))
            }
            
        }
        dataTask.resume()
    }
}
