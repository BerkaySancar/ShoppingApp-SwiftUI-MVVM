//
//  OrderModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 3.08.2024.
//

import Foundation

struct OrderModel: Codable {
    var id = UUID().uuidString
    let total: Double
    var user: UserModel?
    let cart: [CartModel]
}
