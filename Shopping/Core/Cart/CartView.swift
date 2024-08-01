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
                    .scaledToFit()
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
            .padding(.leading, 8)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .lineLimit(2)
                    .padding(.top, 4)
                Text(item.brand)
                    .font(.callout)
                
                Text("$\(item.price, format: .number.precision(.fractionLength(2)))")
                    .padding(.top, 8)
                    .font(.headline)
            }
            
            Spacer()
            
            CustomStepperView(count: item.count, changedValue: { value in
                viewModel.stepperValueChanged(item: item, count: value)
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
                    Text(("$\(viewModel.orderTotal, format: .number.precision(.fractionLength(2)))"))
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
