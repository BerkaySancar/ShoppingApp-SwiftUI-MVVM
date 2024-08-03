//
//  FavoritesViewModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 31.07.2024.
//

import Foundation
import Combine
import DummyAPI

final class FavoritesViewModel: ObservableObject {
    
    private let favoritesManager: FavoritesManagerProtocol
    private let dummyAPIService: DummyAPIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var favorites: [Product] = []
    
    init(favoritesManager: FavoritesManagerProtocol = FavoritesManager(),
         dummyAPIService: DummyAPIServiceProtocol = DummyAPIService()) {
        self.favoritesManager = favoritesManager
        self.dummyAPIService = dummyAPIService
        
        bindFavorites()
    }
    
    private func bindFavorites() {
        favoritesManager.favoritesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] favorites in
                self?.favorites = favorites
            }
            .store(in: &cancellables)
    }
    
    func getFavorites() {
        favoritesManager.getFavorites()
    }
    
    func onDelete(indexSet: IndexSet) {
        for index in indexSet {
            self.favoritesManager.removeFromFavorites(productId: self.favorites[index].id)
        }
    }
}

