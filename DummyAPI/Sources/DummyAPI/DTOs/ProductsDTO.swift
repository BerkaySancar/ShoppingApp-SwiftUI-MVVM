//
//  File.swift
//  
//
//  Created by Berkay Sancar on 28.07.2024.
//

import Foundation

public struct Products: Codable {
    let products: [ProductDTO]
    let total, skip, limit: Int
}

// MARK: - Product
public struct ProductDTO: Codable {
    public let id: Int
    public let title, description: String
    public let category: Category
    public let price, discountPercentage, rating: Double
    public let stock: Int
    public let tags: [String]
    public let brand: String?
    public let sku: String
    public let weight: Int
    public let warrantyInformation, shippingInformation: String
    public let availabilityStatus: AvailabilityStatus
    public let reviews: [Review]
    public let minimumOrderQuantity: Int
    public let images: [String]
    public let thumbnail: String
}

public enum AvailabilityStatus: String, Codable {
    case inStock = "In Stock"
    case lowStock = "Low Stock"
}

public enum Category: String, Codable {
    case beauty = "beauty"
    case fragrances = "fragrances"
    case furniture = "furniture"
    case groceries = "groceries"
}

// MARK: - Review
public struct Review: Codable {
    public let rating: Int
    public let comment: String
    public let reviewerName, reviewerEmail: String
}

