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
    
    @Published var cartItems: [CartModel] = [] {
        didSet {
            calculateOrderTotal()
        }
    }
    @Published var orderTotal: Double = 0
 
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
    
    func stepperValueChanged(item: CartModel, count: Int) {
        if count == 0 {
            self.cartManager.removeFromCart(item: item)
        }
        
        self.cartItems.filter { $0.id == item.id }.first?.count = count
        calculateOrderTotal()
    }
    
    func calculateOrderTotal() {
        orderTotal = 0
        
        for item in cartItems {
            orderTotal += item.price * Double(item.count)
        }
    }
}
