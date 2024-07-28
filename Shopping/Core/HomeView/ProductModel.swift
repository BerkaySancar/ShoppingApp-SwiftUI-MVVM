//
//  ProductModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 28.07.2024.
//

import Foundation

struct Product {
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
        description: "asşdkaşsdkaşsodkasd asşd asşkd asd asdlka şlsd ",
        price: 10.33,
        rating: 4.2,
        brand: "Zara",
        reviews: [Review.sampleReview],
        images: ["https://cdn.dummyjson.com/products/images/furniture/Bedside%20Table%20African%20Cherry/3.png"]
    )
    
    static let sampleProduct2: Product = .init(
        id: 2,
        title: "Poşet",
        description: "asşdkaşsdkaşsodkasd asşd asşkd asd asdlka şlsd ",
        price: 10.33,
        rating: 2,
        brand: "Zara",
        reviews: [Review.sampleReview],
        images: ["https://cdn.dummyjson.com/products/images/furniture/Bedside%20Table%20African%20Cherry/3.png"]
    )
    
    static let sampleProducs: [Product] = [sampleProduct, sampleProduct2]
    
}

struct Review {
    let rating: Int
    let comment: String
    let reviewerName: String
    
    static let sampleReview: Review = .init(rating: 3, comment: "asd asda sda", reviewerName: "Berkay")
}
