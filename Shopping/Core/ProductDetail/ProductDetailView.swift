//
//  ProductDetailView.swift
//  Shopping
//
//  Created by Berkay Sancar on 30.07.2024.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product: Product
    private let favoritesManager: FavoritesManager
    @State var isFav: Bool
    
    init(product: Product,
         favoritesManager: FavoritesManager = .init()) {
        self.product = product
        self.favoritesManager = favoritesManager
        self.isFav = favoritesManager.favorites.contains(where: { $0.id == product.id })
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ScrollView(.vertical) {
                    ProductImageTabView(proxy: proxy)
                    RatingStockView()
                    ProductInfoView(proxy: proxy)
                }
                BottomView()
            }
        }
    }
    
    private func addToCartTapped() {
     
    }
    
    private func addRemoveFavTapped() {
        self.isFav.toggle()
        favoritesManager.isAlreadyFavorite(
            product: product
        ) ? favoritesManager.removeFromFavorites(
            product: product
        ) : favoritesManager.addToFavorite(
            product: product
        )
    }
}

//MARK: - UI Elements
extension ProductDetailView {
    @ViewBuilder
    private func ProductImageTabView(proxy: GeometryProxy) -> some View {
        TabView {
            ForEach(product.images, id: \.self) { imageURLStr in
                AsyncImage(url: URL(string: imageURLStr)) { image in
                    image.image?.resizable()
                }
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
                ForEach(0..<Int(product.rating), id: \.self) { num in
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .padding(.bottom, 8)
                }
            }
            Text("\(product.reviews.count) reviews")
            
            Spacer()
            
            Text("In stock")
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func ProductInfoView(proxy: GeometryProxy) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(product.title)
                    .font(.title3)
                Spacer()
                Text(product.brand ?? "")
                    .font(.callout)
            }
            .padding(.horizontal)
            
            Group {
                Text("$\(product.price, format: .number.precision(.fractionLength(2)))")
                    .bold()
                    .font(.title2)
                
                Text(product.description)
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
                ForEach(product.reviews, id: \.self) { review in
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
    private func BottomView() -> some View {
        HStack {
            HStack {
                Image(systemName: isFav ? "heart.fill" : "heart")
                    .foregroundStyle(.red)
                Button(isFav ? "Remove Favorite" : "Add to Favorite") {
                    addRemoveFavTapped()
                }
            }
            .foregroundStyle(.white)
            .padding()
            .background(RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.appOrange))
            
            Spacer()
            HStack {
                Image(systemName: "cart")
                Button("Add to Cart") {
                    
                }
            }
            .foregroundStyle(.white)
            .padding()
            .background(RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.appOrange))
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(.grayBackground))
        .padding(.horizontal, 8)
    }
}

#Preview {
    ProductDetailView(product: .sampleProduct)
}
