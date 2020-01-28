//
//  ApiClient.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

enum HTTPHeaderField {
    static let contentType = "Content-Type"
}

enum ContentType {
    static let applicationJson = "application/json"
}

enum EnvironmentURL {
    static let baseUrl = "http://my-json-server.typicode.com/"
}

class ApiClient<T: Decodable> {
    
    // MARK: - Public Methods
    
    static func makeRequest(toURL url: String,
                     withHttpMethod httpMethod: HttpMethod = .get,
                     httpHeaders: [String: String] = [HTTPHeaderField.contentType: ContentType.applicationJson],
                     queryParameters: [String: String]? = nil,
                     bodyParameters: [String: AnyHashable]? = nil,
                     completion: @escaping (_ value: T?, _ error: CustomError?) -> Void) {
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, CustomError.noInternet)
            return
        }
        
        guard let url = URL(string: url) else {
            completion(nil, .badUrlRequest)
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let targetURL = self.add(queryParams: queryParameters, toURL: url)
            let httpBody = self.getHttpDataWith(bodyParam: bodyParameters)
            
            guard let request = self.prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: httpMethod, headers: httpHeaders) else {
                completion(nil, .badUrlRequest)
                return
            }
            
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if let _ = error {
                        completion(nil, .serverError)
                    } else {
                        guard let data = data, let response = try? JSONDecoder().decode(T.self, from: data) else {
                            completion(nil, .badResponse)
                            return
                        }
                        completion(response, nil)
                    }
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Private Methods
    
    static private func add(queryParams: [String: String]?, toURL url: URL) -> URL {
        guard let queryParams = queryParams, queryParams.count > 0 else {
            return url
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
        var queryItems = [URLQueryItem]()
        for (key, value) in queryParams {
            let item = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            queryItems.append(item)
        }
        urlComponents.queryItems = queryItems
        guard let updatedURL = urlComponents.url else { return url }
        return updatedURL
    }
    
    static private func getHttpDataWith(bodyParam: [String: AnyHashable]?)-> Data? {
        guard let bodyParm = bodyParam else { return nil }
        return try? JSONSerialization.data(withJSONObject: bodyParm, options: [.prettyPrinted, .sortedKeys])
    }
    
    static private func prepareRequest(withURL url: URL?, httpBody: Data?, httpMethod: HttpMethod, headers: [String: String]) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        for (header, value) in headers {
            request.setValue(value, forHTTPHeaderField: header)
        }
        request.httpBody = httpBody
        return request
    }
}


// MARK: - ApiClient Custom Types
extension ApiClient {
    
    enum HttpMethod: String {
        case get
        case post
        case put
        case patch
        case delete
    }
}
