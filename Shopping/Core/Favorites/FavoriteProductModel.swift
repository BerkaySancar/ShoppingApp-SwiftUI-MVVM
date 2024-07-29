//
//  FavoriteProductModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 29.07.2024.
//

import Foundation

struct FavoriteProduct: Codable {
    let id: Int
    let title: String
    let price: Double
    let images: [String]
}
