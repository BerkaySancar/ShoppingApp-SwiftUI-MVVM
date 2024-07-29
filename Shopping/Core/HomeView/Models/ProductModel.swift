//
//  ProductModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 28.07.2024.
//

import Foundation

struct Product: Codable {
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
        reviews: [Review.sampleReview],
        images: ["https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"]
    )
}

struct Review: Codable {
    let rating: Int
    let comment: String
    let reviewerName: String
    
    static let sampleReview: Review = .init(rating: 1, comment: "asdas", reviewerName: "Berkay")
}
