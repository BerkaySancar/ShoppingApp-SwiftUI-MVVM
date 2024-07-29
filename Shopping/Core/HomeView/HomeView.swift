//
//  HomeView.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import SwiftUI

struct HomeView: View {
     
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                ZStack {
                    Color.appGrayBackground
                        .ignoresSafeArea()
                    
                    VStack(alignment: .leading) {
                        SearchFilterView(proxy: proxy)
                        CategorySliderView()
                        ScrollView {
                            ScrollableProductsView()
                                .padding(.bottom, 70)
                        }
                        .padding(.horizontal, 8)
                    }
                    
                    CustomProgressView(isVisible: $viewModel.showActivity)
                }
            }
            .alert(isPresented: $viewModel.presentAlert) {
                Alert(title: Text(viewModel.errorMessage))
            }
        }
    }
}

//MARK: - Views
extension HomeView {
    @ViewBuilder
    private func SearchFilterView(proxy: GeometryProxy) -> some View {
        HStack {
            TextField("", text: $viewModel.searchText, prompt: Text("Search Product"))
                .textFieldStyle(.plain)
                .frame(width: proxy.size.width / 1.4)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.white))
                .autocorrectionDisabled(true)
                .padding(.leading, 8)
                
            Menu {
                ForEach(HomeFilterOptions.allCases, id: \.self) { filter in
                    Button(filter.rawValue) {
                        viewModel.filterSelected(selectedFilter: filter)
                    }
                }
            } label: {
                Image(systemName: "slider.vertical.3")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.appOrange))
                    .foregroundStyle(.white)
            }
        }
    }
    
    @ViewBuilder
    private func CategorySliderView() -> some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible(minimum: 1))]) {
                ForEach(viewModel.categories.prefix(10), id: \.self) { category in
                    Button(category.capitalized) {
                        viewModel.getCategoryProducts(category: category)
                        viewModel.selectedCategory = category
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(viewModel.selectedCategory == category ? .appOrange : .white))
                    .foregroundStyle(viewModel.selectedCategory == category ? .white : .appOrange)
                }
            }
            .padding(.horizontal, 10)
        }
        .scrollIndicators(.never, axes: .horizontal)
        .frame(height: 80)
    }
    
    @ViewBuilder
    private func ScrollableProductsView() -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 130))]) {
            ForEach(viewModel.content, id: \.id) { product in
                NavigationLink {
                    
                } label: {
                    VStack {
                        ZStack {
                            AsyncImage(url: .init(string: product.images.first!)!) { image in
                                image.image?.resizable()
                            }
                            .frame(width: 150, height: 150)
                            
                            Button {
                                viewModel.favTapped(product: product)
                            } label: {
                                Image(systemName: viewModel.favorites.contains(where: {$0.id == product.id }) ? "heart.fill" : "heart")
                                    .font(.system(size: 24))
                                    .padding()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(.appOrange)
                                    .background(Capsule().foregroundStyle(.grayBackground))
                            }
                            .offset(x: 70, y: -50)
                        }
                        
                        Text(product.title)
                            .frame(maxWidth: .infinity)
                            .lineLimit(2)
                            .padding(.horizontal, 4)
                        Text("$\(product.price, format: .number.precision(.fractionLength(2)))")
                            .bold()
                        
                        LazyHStack(spacing: 1) {
                            ForEach(0...Int(product.rating), id: \.self) { num in
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(.yellow)
                                        .padding(.bottom, 8)
                                }
                            }
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.white))
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
