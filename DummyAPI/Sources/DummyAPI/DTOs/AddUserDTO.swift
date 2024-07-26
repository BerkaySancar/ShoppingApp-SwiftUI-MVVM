//
//  File.swift
//  
//
//  Created by Berkay Sancar on 26.07.2024.
//

import Foundation

public struct AddUserDTO: Codable {
    public let firstName: String
    public let lastName: String
    public let username: String
    public let password: String
}
