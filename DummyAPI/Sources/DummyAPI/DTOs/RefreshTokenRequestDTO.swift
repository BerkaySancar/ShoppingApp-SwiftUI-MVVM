//
//  File.swift
//  
//
//  Created by Berkay Sancar on 2.08.2024.
//

import Foundation

public struct RefreshTokenRequestDTO: Codable {
    public let refreshToken: String
    public let expiresInMins: Int
}
