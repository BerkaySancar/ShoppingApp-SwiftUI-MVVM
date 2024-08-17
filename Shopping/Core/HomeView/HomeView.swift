//
//  HomeView.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = HomeViewModel()
    @State private var isScrollDown = true
    
    var body: some View {
        ZStack {
            Color.appGrayBackground
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 4) {
                SearchFilterView()
                
                if isScrollDown {
                    VStack {
                        CategorySliderView()
                    }
                }
                
                ScrollView {
                    ProductsGridView()
                        .padding(.bottom, 70)
                }
                .simultaneousGesture(
                    DragGesture().onChanged {
                        self.isScrollDown = 0 < $0.translation.height
                    }
                )
                .scrollIndicators(.never)
                .padding(.horizontal, 8)
            }
            
            CustomProgressView(isVisible: $viewModel.showActivity)
        }
        .onAppear {
            viewModel.onAppear()
        }
        .alert(isPresented: $viewModel.presentAlert) {
            Alert(title: Text(viewModel.errorMessage))
        }
    }
}

//MARK: - Views
extension HomeView {
    @ViewBuilder
    private func SearchFilterView() -> some View {
        HStack {
            TextField("", text: $viewModel.searchText, prompt: Text("Search Product"))
                .textFieldStyle(.plain)
                .padding(.all, 10)
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
                    .padding(.all, 12)
                    .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.appOrange))
                    .foregroundStyle(.white)
            }
        }
        .padding(.trailing, 8)
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
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(viewModel.selectedCategory == category ? .appOrange : .white))
                    .foregroundStyle(viewModel.selectedCategory == category ? .white : .appOrange)
                }
            }
            .padding(.horizontal, 10)
        }
        .scrollIndicators(.never, axes: .horizontal)
        .frame(height: 60)
    }
 
    @ViewBuilder
    private func ProductsGridView() -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))]) {
            ForEach(viewModel.content, id: \.id) { product in
                ProductCell(viewModel: self.viewModel, product: product)
                .onAppear {
                    viewModel.loadMoreProduct(productShown: product)
                }
                .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.white))
                .onTapGesture {
                    coordinator.push(.productDetail(product))
                }
            }
        }
    }
    
    
    @ViewBuilder
    private func ProductCell(viewModel: HomeViewModel, product: Product) -> some View {
        VStack(spacing: 0) {
            ZStack {
                AsyncImage(url: .init(string: product.images.first!)!) { image in
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
                    .offset(y: 20)
                }
                .frame(width: 120, height: 120)
                
                Button {
                    viewModel.favTapped(product: product)
                } label: {
                    Image(systemName: viewModel.favoritesManager.favorites.contains(where: { $0.id == product.id}) ? "heart.fill" : "heart")
                        .font(.system(size: 24))
                        .padding()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.appOrange)
                        .background(Capsule().foregroundStyle(.grayBackground))
                }
                .offset(x: 68, y: -35)
            }
            
            Text(product.title)
                .frame(maxWidth: .infinity, minHeight: 60)
                .lineLimit(2)
                .padding(.horizontal, 4)
            Text("$\(product.price, format: .number.precision(.fractionLength(2)))")
                .bold()
            
            LazyHStack(spacing: 1) {
                ForEach(0..<Int(product.rating), id: \.self) { num in
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .padding([.top, .bottom], 8)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Coordinator())
}
