//
//  File.swift
//  
//
//  Created by Berkay Sancar on 26.07.2024.
//

import Foundation

public struct LoginRequestDTO: Codable {
    public let username: String
    public let password: String
    public let expiresInMins: Int
}
