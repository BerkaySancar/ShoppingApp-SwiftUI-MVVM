//
//  ProductDetailView.swift
//  Shopping
//
//  Created by Berkay Sancar on 30.07.2024.
//

import SwiftUI

struct ProductDetailView: View {
    
    @ObservedObject private var viewModel = ProductDetailVM()
    
    @State private var showCart = false
    
    init(product: Product) {
        self.viewModel.product = product
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                VStack {
                    ScrollView(.vertical) {
                        ProductImageTabView(proxy: proxy)
                        RatingStockView()
                        ProductInfoView(proxy: proxy)
                    }
                    BottomView(proxy: proxy)
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.navigateCart) {
            CartView()
        }
    }
}

//MARK: - UI Elements
extension ProductDetailView {
    @ViewBuilder
    private func ProductImageTabView(proxy: GeometryProxy) -> some View {
        TabView {
            ForEach(viewModel.product.images, id: \.self) { imageURLStr in
                AsyncImage(url: URL(string: imageURLStr)) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 0)
                            .foregroundStyle(.grayBackground)
                        
                        Image(systemName: "photo")
                            .foregroundStyle(.white)
                            .font(.system(size: 40))
                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height / 2)
            }
        }
        .frame(width: proxy.size.width, height: proxy.size.height / 2)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    
    
    @ViewBuilder
    private func RatingStockView() -> some View {
        HStack(alignment: .top) {
            LazyHStack(spacing: 1) {
                ForEach(0..<Int(viewModel.product.rating), id: \.self) { num in
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .padding(.bottom, 8)
                }
            }
            Text("\(viewModel.product.reviews.count) reviews")
            
            Spacer()
            
            Text("In stock")
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func ProductInfoView(proxy: GeometryProxy) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.product.title)
                    .font(.title3)
                Spacer()
                Text(viewModel.product.brand ?? "Shopping App")
                    .font(.callout)
                    .padding(.all, 8)
                    .background(RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.grayBackground))
            }
            .padding(.leading, 16)
            .padding(.trailing, 8)
            
            Group {
                Text("$\(viewModel.product.price, format: .number.precision(.fractionLength(2)))")
                    .bold()
                    .font(.title2)
                
                Text(viewModel.product.description)
                    .padding(.top, 8)
                
                Text("Comments")
                    .padding(.top, 12)
                    .padding(.trailing, 8)
                    .font(.headline)
            }
            .padding(.horizontal)
            
            ReviewsView()
   
        }
        .padding(.top, 12)
    }
    
    @ViewBuilder
    private func ReviewsView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.product.reviews, id: \.self) { review in
                    VStack(alignment: .leading) {
                        Text(review.reviewerName)
                            .foregroundColor(.black.opacity(0.75))
                        Text(review.comment)
                            .foregroundColor(.black.opacity(0.5))
                        Text("Rating: \(review.rating)")
                            .foregroundStyle(.black.opacity(0.5))
                            .padding(.top, 12)
                            .frame(width: 160)
                    }
                    .font(.callout)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.grayBackground))
                }
            }
        }
        .padding(.horizontal,8)
    }
    
    @ViewBuilder
    private func BottomView(proxy: GeometryProxy) -> some View {
        VStack {
            Rectangle()
                .frame(width: proxy.size.width, height: 1)
                .foregroundStyle(.grayBackground)
            HStack {
                  Spacer()
                  
                  CustomButton(
                      imageName: viewModel.isFav ? "heart.fill" : "heart",
                      buttonText: viewModel.isFav ? "Remove Favorite" : "Add to Favorite",
                      action: { viewModel.addRemoveFavTapped(product: viewModel.product) },
                      imageTint: .red,
                      width: 128
                  )
                  
                  CustomButton(
                      imageName: "cart",
                      buttonText: "Add to Cart",
                      action: { viewModel.addToCartTapped() },
                      imageTint: .white,
                      width: 128
                  )
                  
                  Spacer()
              }
              .padding(.all, 8)
              .padding(.horizontal, 8)
        }
    }
}

#Preview {
    ProductDetailView(product: .sampleProduct)
}
