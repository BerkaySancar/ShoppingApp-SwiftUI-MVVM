//
//  File.swift
//  
//
//  Created by Berkay Sancar on 1.08.2024.
//

import Foundation

public struct LoginResponseDTO: Codable {
    public let id: Int
    public let username: String
    public let email: String
    public let firstName: String
    public let lastName: String
    public let gender: String
    public let image: String
    public let token: String
    public let refreshToken: String
}
