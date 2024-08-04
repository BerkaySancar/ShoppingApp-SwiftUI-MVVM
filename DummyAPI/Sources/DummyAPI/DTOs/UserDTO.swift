//
//  File.swift
//  
//
//  Created by Berkay Sancar on 1.08.2024.
//

import Foundation

public struct UserDTO: Codable {
    public let id: Int
    public let username: String
    public let email: String
    public let firstName: String
    public let lastName: String
    public let gender: String
    public let image: String
    public let address: AddressDTO
    public let bank: BankDTO
}

public struct AddressDTO: Codable {
    public let address: String
    public let city: String
    public let state: String
    public let country: String
    public let coordinates: CoordinateDTO
}

public struct CoordinateDTO: Codable {
    public let lat: Double
    public let lng: Double
}

public struct BankDTO: Codable {
    public let cardExpire: String
    public let cardNumber: String
    public let cardType: String
    public let currency: String
    public let iban: String
}
