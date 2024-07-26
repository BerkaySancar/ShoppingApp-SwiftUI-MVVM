//
//  File.swift
//  
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

protocol URLRequestConvertible {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethods { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension URLRequestConvertible {
    func urlRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        if let headers {
            headers.forEach { key, value in
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameters {
            switch httpMethod {
            case .get:
                if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                    components.queryItems = parameters.map { key, value in
                        URLQueryItem(name: key, value: "\(value)")
                    }
                    urlRequest.url = components.url
                }
                
            case .patch, .put, .post, .delete:
                let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
                urlRequest.httpBody = jsonData
            }
        }
        
        return urlRequest
    }
}

/// for model to dictionary convert
extension Encodable {
    func convertToDictionary() -> [String: Any]? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            guard let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                return nil
            }
            return jsonObject
        } catch {
            print("JSON encoding error: \(error)")
            return nil
        }
    }
}
