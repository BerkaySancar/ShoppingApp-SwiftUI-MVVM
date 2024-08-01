//
//  UserModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 1.08.2024.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String
    
    static let sampleUser: UserModel = .init(
        id: 1,
        username: "Berkay Sancar",
        email: "sancarberkay@gmail.com",
        firstName: "Berkay",
        lastName: "Sancar",
        gender: "Male",
        image: "https://dummyjson.com/icon/emilys/128"
    )
}
