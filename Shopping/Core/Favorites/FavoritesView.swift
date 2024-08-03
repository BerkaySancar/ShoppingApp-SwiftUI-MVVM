//
//  FavoritesView.swift
//  Shopping
//
//  Created by Berkay Sancar on 31.07.2024.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        VStack {
            if !viewModel.favorites.isEmpty {
                List {
                    Section {
                        ForEach(viewModel.favorites, id: \.id) { favorite in
                            NavigationLink {
                                ProductDetailView(product: favorite)
                            } label: {
                                ItemRow(favorite: favorite)
                            }
                        }
                        .onDelete { indexSet in
                            viewModel.onDelete(indexSet: indexSet)
                        }
                    } header: {
                        Text("Favorites")
                            .font(.headline)
                            .foregroundStyle(.appOrange)
                    }
                }
            } else {
                EmptyContentView(
                    title: "Favorites are empty.",
                    description: "You can add favorites some products."
                )
            }
        }
        .onAppear {
            viewModel.getFavorites()
        }
    }
}

extension FavoritesView {
    @ViewBuilder
    private func ItemRow(favorite: Product) -> some View {
        HStack {
            AsyncImage(url: .init(string: favorite.images.first!)!) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundStyle(.grayBackground)
                        .frame(width: 60, height: 60)

                    Image(systemName: "photo")
                        .foregroundStyle(.white)
                        .font(.system(size: 40))
                }
            }
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(favorite.title)
                    .font(.headline)
                    .lineLimit(2)
                    .padding(.all, 8)
                
                Text("$\(favorite.price, format: .number.precision(.fractionLength(2)))")
                    .padding(.all, 8)
                    .font(.headline)
            }
        }
    }
}

#Preview {
    FavoritesView()
}
