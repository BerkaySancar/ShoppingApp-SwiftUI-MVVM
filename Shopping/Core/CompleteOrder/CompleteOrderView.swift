//
//  CompleteOrderView.swift
//  Shopping
//
//  Created by Berkay Sancar on 3.08.2024.
//

import SwiftUI

struct CompleteOrderView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var viewModel = CompleteOrderVM()
        
    init(order: OrderModel) {
        viewModel.order = order
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                List {
                    Section("Address") {
                        AddressView()
                    }
                    
                    Section("Credit Card") {
                        CreditCardView(proxy: proxy)
                    }
                    
                    Section("Payment") {
                        PaymentView()
                    }
                }
                
                CustomProgressView(isVisible: $viewModel.showActivity)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(viewModel.alertMessage),
                    dismissButton: .cancel(Text("Done"), action: { self.dismiss() }))
            }
        }
    }
}

extension CompleteOrderView {
    @ViewBuilder
    private func AddressView() -> some View {
        VStack(alignment: .leading) {
            Text(
"""
\(viewModel.user?.address.city ?? ""), \(viewModel.user?.address.country ?? "")

\(viewModel.user?.address.address ?? "")
\(viewModel.user?.address.state ?? "")
"""
            )
            .font(.callout)
            .padding(.horizontal, 8)
        }
    }
    
    @ViewBuilder
    private func CreditCardView(proxy: GeometryProxy) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: (proxy.size.width / 1.2), height: 180)
                .foregroundStyle(.cyan.opacity(0.55))
            
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(viewModel.user?.bank.cardNumber ?? "")
                        Spacer()
                        Text("\(viewModel.user?.bank.cardType ?? ""), \(viewModel.user?.bank.currency ?? "")")
                    }
                    .padding(.bottom, 30)
                    
                    HStack {
                        Text("\(viewModel.user?.firstName ?? "") \(viewModel.user?.lastName ?? "")")
                        Spacer()
                        Text(viewModel.user?.bank.cardExpire ?? "")
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            .foregroundStyle(.white)
        }
        .padding(.vertical, 16)
    }
    
    @ViewBuilder
    private func PaymentView() -> some View {
        VStack {
            HStack {
                Text("Cart: ")
                Spacer()
                Text("$12313")
            }
            
            HStack {
                Text("Delivery: ")
                Spacer()
                Text("$20")
            }
            
            HStack {
                Text("Total: ")
                    .bold()
                Spacer()
                Text("$201313")
                    .bold()
            }
            
            Button("Complete Order") {
                viewModel.completeOrder()
            }
            .padding()
            .foregroundStyle(.white)
            .background(RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(.appOrange))
        }
        .font(.callout)
    }
}

#Preview {
    CompleteOrderView(order: .init(total: 333, user: .sampleUser, cart: [.sampleCartModel]))
}

