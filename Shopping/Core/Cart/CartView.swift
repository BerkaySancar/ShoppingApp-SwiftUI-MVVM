//
//  CartView.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import SwiftUI

struct CartView: View {
    
    @StateObject private var viewModel = CartViewModel()
        
    var body: some View {
        ZStack {
            Color.grayBackground
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                VStack {
                    if !viewModel.cartItems.isEmpty {
                        ScrollView(.vertical) {
                            ForEach(viewModel.cartItems, id: \.id) { item in
                                ItemRowView(item: item)
                            }
                        }
                    } else {
                        Spacer()
                        EmptyContentView(title: "Cart is empty.", description: "Add items to your cart to purchase.")
                    }
                    Spacer()
                    
                    BottomView(proxy: proxy)
                }
            }
        }
    }
}

extension CartView {
    
    @ViewBuilder
    private func ItemRowView(item: CartModel) -> some View {
        HStack {
            AsyncImage(url: .init(string: item.images.first!)!) { image in
                image.resizable()
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundStyle(.grayBackground)
                        .frame(width: 80, height: 80)

                    Image(systemName: "photo")
                        .foregroundStyle(.white)
                        .font(.system(size: 40))
                }
            }
            .frame(width: 120, height: 120)
            .padding(.leading, 12)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .bold()
                    .lineLimit(2)
                Text(item.brand)
                    .font(.callout)
                
                Text("$\(item.price)")
                    .padding(.top, 38)
                    .font(.title3).bold()
            }
            
            Spacer()
            
            CustomStepperView(count: item.count, countEqualZero: {
                viewModel.removeItemFromCart(item: item)
                print(item.count)
            })
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(.white))
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func BottomView(proxy: GeometryProxy) -> some View {
        VStack {
            VStack {
                Rectangle()
                    .frame(width: proxy.size.width, height: 1)
                    .foregroundStyle(.appOrange)
                HStack {
                    Text("Order total:")
                        .font(.headline)
                    Spacer()
                    Text("$123123.123")
                        .font(.headline)
                }
                .padding()
            }
            Button {
                
            } label: {
                Text("Continue")
                    .padding(.top, 30)
                    .font(.headline)
            }
            .frame(width: proxy.size.width, height: 40)
            .background(.appOrange)
            .foregroundStyle(.white)
        }
        .background(.white)
    }

}

#Preview {
    CartView()
}
