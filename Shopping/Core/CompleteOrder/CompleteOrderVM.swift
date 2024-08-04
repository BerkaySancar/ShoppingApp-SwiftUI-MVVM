//
//  CompleteOrderVM.swift
//  Shopping
//
//  Created by Berkay Sancar on 4.08.2024.
//

import Foundation
import DummyAPI

final class CompleteOrderVM: ObservableObject {
    
    private let userDefaultsManager: UserDefaultManagerProtocol
    private let dummyAPIService: DummyAPIServiceProtocol
    private let cartManager: CartManagerProtocol
    
    private(set) var user: UserModel?
    private var completedOrders: [OrderModel] = []
    
    var order: OrderModel? {
        didSet {
            getAuthUser()
        }
    }
   
    @Published var showAlert = false
    @Published var showActivity = false
    
    private(set) var alertMessage = ""
    
    init(userDefaultsManager: UserDefaultManagerProtocol = USerDefaultManager(),
         dummyAPIService: DummyAPIServiceProtocol = DummyAPIService(),
         cartManager: CartManagerProtocol = CartManager()) {
        self.userDefaultsManager = userDefaultsManager
        self.dummyAPIService = dummyAPIService
        self.cartManager = cartManager
        
        getCompletedOrders()
    }
    
    func getCompletedOrders() {
        self.completedOrders = userDefaultsManager.getItem(key: .completedOrder, type: [OrderModel].self) ?? []
    }
    
    func completeOrder() {
        self.order?.user = self.user
        
        if let order {
            self.completedOrders.append(order)
            userDefaultsManager.addItem(key: .completedOrder, item: self.completedOrders)
        }
       
        showActivity.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.cartManager.removeAll()
            self.showActivity.toggle()
            self.alertMessage = "Order successfully created."
            self.showAlert.toggle()
        }
    }
    
    func getAuthUser() {
        if let token = userDefaultsManager.getItem(key: .authToken, type: String.self) {
            dummyAPIService.getAuthUser(token: token) { [weak self] results in
                guard let self else { return }
                DispatchQueue.main.async {
                    switch results {
                    case .success(let user):
                        self.user = user.map {
                            UserModel(
                                id: $0.id,
                                username: $0.username,
                                email: $0.email,
                                firstName: $0.firstName,
                                lastName: $0.lastName,
                                gender: $0.gender,
                                image: $0.image,
                                address: Address(
                                    address: $0.address.address,
                                    city: $0.address.city,
                                    state: $0.address.state,
                                    country: $0.address.country,
                                    coordinates: Coordinate(
                                        lat: $0.address.coordinates.lat,
                                        lng: $0.address.coordinates.lng
                                    )
                                ),
                                bank: Bank(
                                    cardExpire: $0.bank.cardExpire,
                                    cardNumber: $0.bank.cardNumber,
                                    cardType: $0.bank.cardType,
                                    currency: $0.bank.currency,
                                    iban: $0.bank.iban
                                )
                            )
                        }
                    case .failure(let failure):
                        if failure == .unauthorized {
                            if let refreshToken = self.userDefaultsManager.getItem(key: .refreshToken, type: String.self) {
                                self.dummyAPIService.refreshToken(refreshToken: refreshToken, expiresInMins: 10) { results in
                                    switch results {
                                    case .success(let success):
                                        self.userDefaultsManager.addItem(key: .authToken, item: success?.token)
                                        self.userDefaultsManager.addItem(key: .refreshToken, item: success?.refreshToken)
                                    case .failure(let failure):
                                        self.showAlert.toggle()
                                        self.alertMessage = failure.errorDescription
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
