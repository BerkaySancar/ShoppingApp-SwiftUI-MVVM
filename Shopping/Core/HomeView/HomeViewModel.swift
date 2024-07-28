//
//  HomeViewModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 28.07.2024.
//

import Foundation
import DummyAPI

protocol HomeViewModelProtocol {
    func getProducts()
}

final class HomeViewModel: ObservableObject {
    
    //Dependencies
    private let dummyService: DummyAPIServiceProtocol
    
    //Published
    @Published var products: [Product] = []
    @Published var showActivity = false
    
    //Init
    init(dummyService: DummyAPIServiceProtocol = DummyAPIService()) {
        self.dummyService = dummyService
    }
}

//MARK: - View Model Protocols
extension HomeViewModel: HomeViewModelProtocol {
    
    func getProducts() {
        dummyService.getProducts { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let data):
                if let data {
                    self.products = data.map {
                        Product(
                            id: $0.id,
                            title: $0.title,
                            description: $0.description,
                            price: $0.price,
                            rating: $0.rating,
                            brand: $0.brand,
                            reviews: $0.reviews.map {
                                Review(
                                    rating: $0.rating,
                                    comment: $0.comment,
                                    reviewerName: $0.reviewerName
                                )
                            },
                            images: $0.images
                        )
                    }
                }
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
}
