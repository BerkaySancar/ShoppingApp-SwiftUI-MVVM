//
//  CartViewModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 31.07.2024.
//

import Foundation
import Combine

final class CartViewModel: ObservableObject {
    
    private let cartManager: CartManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var cartItems: [CartModel] = []
 
    init(cartManager: CartManagerProtocol = CartManager()) {
        self.cartManager = cartManager
        
        observeCartItems()
    }
    
    private func observeCartItems() {
        cartManager.cartItemsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.cartItems = items
            }
            .store(in: &cancellables)
     }
    
    func removeItemFromCart(item: CartModel) {
        self.cartManager.removeFromCart(item: item)
    }
}
