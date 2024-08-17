//
//  UserModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 1.08.2024.
//

import Foundation

struct UserModel: Codable, Hashable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String
    let address: Address
    let bank: Bank
    
    static let sampleUser: UserModel = .init(
        id: 1,
        username: "Berkay Sancar",
        email: "sancarberkay@gmail.com",
        firstName: "Berkay",
        lastName: "Sancar",
        gender: "Male",
        image: "https://dummyjson.com/icon/emilys/128",
        address: .init(address: "asdasd", city: "İst", state: "İdeal", country: "Tr", coordinates: .init(lat: 1, lng: 1)),
        bank: .init(cardExpire: "223", cardNumber: "2342342", cardType: "adasd", currency: "tl mlsf", iban: "1231231231")
    )
}

struct Address: Codable, Hashable {
    let address: String
    let city: String
    let state: String
    let country: String
    let coordinates: Coordinate
}

struct Coordinate: Codable, Hashable {
    let lat: Double
    let lng: Double
}

struct Bank: Codable, Hashable {
    let cardExpire: String
    let cardNumber: String
    let cardType: String
    let currency: String
    let iban: String
}
