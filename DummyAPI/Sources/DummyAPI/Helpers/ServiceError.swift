//
//  File.swift
//  
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

public enum ServiceError: Error {
    case invalidURL
    case invalidResponse
    case invalidURLRequest
    case requestFailed
    case noConnection
    case unauthorized
    case rateLimit
    
    public var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Something went wrong."
        case .invalidResponse:
            return "Invalid response."
        case .requestFailed:
            return "Request failed."
        case .invalidURLRequest:
            return "Something went wrong."
        case .noConnection:
            return "No internet connection."
        case .unauthorized:
           return "Unauthorized request."
        case .rateLimit:
            return "You've exceeded the Rate Limit."
        }
    }
}
