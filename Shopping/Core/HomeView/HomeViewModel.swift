//
//  HomeViewModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 28.07.2024.
//

import Foundation
import DummyAPI
import Combine

protocol HomeViewModelProtocol {
    func getProducts()
    func getFavs()
    func favTapped(product: Product)
    func filterSelected(selectedFilter: HomeFilterOptions)
    func getCategories()
}

enum HomeFilterOptions: String, CaseIterable {
    case sortByName = "[A-Z] Sort by name"
    case increasingPrice = "[$++] Increasing price "
    case decreasingPrice = "[$--] Decreasing price "
}

final class HomeViewModel: ObservableObject {
    
    //Dependencies
    private let dummyService: DummyAPIServiceProtocol
    private let userDefaultsManager: UserDefaultManagerProtocol
    
    //Published
    @Published var content: [Product] = []
    @Published var products: [Product] = []
    @Published var favorites: [FavoriteProduct] = []
    @Published var searchedProducts: [Product] = []
    @Published var categories: [String] = []
    @Published var showActivity = false
    @Published var presentAlert = false
    @Published var searchText = ""
    @Published var selectedCategory = "All"
    
    //Variables
    private var cancellables = Set<AnyCancellable>()
    private(set) var errorMessage = ""
    
    //Init
    init(dummyService: DummyAPIServiceProtocol = DummyAPIService(),
         userDefaultManager: UserDefaultManagerProtocol = USerDefaultManager()) {
        self.dummyService = dummyService
        self.userDefaultsManager = userDefaultManager
        
        self.listenSearchText()
        self.getProducts()
        self.getCategories()
    }
    
    private func listenSearchText() {
        $searchText
            .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                if newValue.count > 3 {
                    self?.searchProduct(query: newValue)
                } else {
                    self?.content = self?.products ?? []
                }
            }
            .store(in: &cancellables)
    }
}

//MARK: - View Model Protocols
extension HomeViewModel: HomeViewModelProtocol {
    
    func getProducts() {
        self.showActivity = true
        dummyService.getProducts { [weak self] results in
            guard let self else { return }
            DispatchQueue.main.async {
                self.showActivity = false
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
                        
                        self.content = self.products
                        self.getFavs()
                    }
                case .failure(let failure):
                    self.errorMessage = failure.errorDescription
                    self.presentAlert.toggle()
                }
            }
        }
    }
    
    func getFavs() {
        self.favorites = userDefaultsManager.getItem(key: .favorite, type: [FavoriteProduct].self) ?? []
    }
    
    func favTapped(product: Product) {
        if self.favorites.contains(where: {$0.id == product.id}) {
            self.favorites.removeAll(where: {$0.id == product.id})
        } else {
            let favorite = FavoriteProduct(
                id: product.id,
                title: product.title,
                price: product.price,
                images: product.images
            )
            self.favorites.append(favorite)
        }
        self.userDefaultsManager.addItem(key: .favorite, item: self.favorites)
    }
    
    func filterSelected(selectedFilter: HomeFilterOptions) {
        switch selectedFilter {
        case .sortByName:
            self.content = self.content.sorted { $0.title < $1.title }
        case .increasingPrice:
            self.content = self.content.sorted { $0.price < $1.price }
        case .decreasingPrice:
            self.content = self.content.sorted { $0.price > $1.price }
        }
    }
    
    func searchProduct(query: String) {
        self.showActivity = true
        dummyService.searchProducts(query: searchText.lowercased()) { [weak self] results in
            guard let self else { return }
            DispatchQueue.main.async {
                self.showActivity = false
                switch results {
                case .success(let data):
                    if let data {
                        self.searchedProducts = data.map {
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
                        self.content = self.searchedProducts
                    }
                case .failure(let failure):
                    self.errorMessage = failure.errorDescription
                    self.presentAlert.toggle()
                }
            }
        }
    }
    
    func getCategories() {
        self.showActivity = true
        dummyService.getCategories { [weak self] results in
            guard let self else { return }
            DispatchQueue.main.async {
                self.showActivity = false
                switch results {
                case .success(let data):
                    if let data {
                        self.categories = data
                        self.categories.insert("All", at: 0)
                    }
                case .failure(let failure):
                    self.errorMessage = failure.errorDescription
                    self.presentAlert.toggle()
                }
            }
        }
    }
    
    func getCategoryProducts(category: String) {
        if category.lowercased().contains("all") {
            self.content = self.products
        } else {
            self.showActivity = true
            dummyService.getCategoryProducts(category: category) { [weak self] results in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.showActivity = false
                    switch results {
                    case .success(let data):
                        if let data {
                            self.content = data.map {
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
                        self.errorMessage = failure.errorDescription
                        self.presentAlert.toggle()
                    }
                }
            }
        }
    }
}
