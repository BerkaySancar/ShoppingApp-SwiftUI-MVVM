//
//  ProductModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 28.07.2024.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let rating: Double
    let brand: String?
    let reviews: [Review]
    let images: [String]
    
    static let sampleProduct: Product = .init(
        id: 1,
        title: "Ayakkabı",
        description: "asşdlkasd aşsda sd aşsdk a",
        price: 3.33,
        rating: 3.5,
        brand: "zara",
        reviews: [Review.sampleReview, Review.sampleReview],
        images: [
            "https://cdn.dummyjson.com/products/images/fragrances/Dolce%20Shine%20Eau%20de/1.png",
            "https://cdn.dummyjson.com/products/images/fragrances/Dolce%20Shine%20Eau%20de/2.png",
            "https://cdn.dummyjson.com/products/images/fragrances/Dolce%20Shine%20Eau%20de/3.png"
        ]
    )
}

struct Review: Codable, Hashable {
    let rating: Int
    let comment: String
    let reviewerName: String
    
    static let sampleReview: Review = .init(rating: 1, comment: "asdas", reviewerName: "Berkay")
}
