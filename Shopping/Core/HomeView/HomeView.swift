//
//  HomeView.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import SwiftUI

struct HomeView: View {
     
    @State private var searchText = ""
    @State private var categories: [String] = ["aasd", "basd", "csss", "ddasda", "esss", "fdas", "g"]
    
    @State private var products: [Product] = [Product.sampleProduct, Product.sampleProduct]
    
    @StateObject private var viewModel = HomeViewModel()
    
  
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                ZStack {
                    Color.appGrayBackground
                        .ignoresSafeArea()
                    VStack {
                        SearchFilterView(proxy: proxy)
                        CategorySliderView()
                        
                        ScrollView {
                            ProductsScrollableView()
                        }
                    }
                }
            }
        }
    }
}

//MARK: - Views
extension HomeView {
    @ViewBuilder
    private func SearchFilterView(proxy: GeometryProxy) -> some View {
        HStack {
            TextField("", text: $searchText, prompt: Text("Search Product"))
                .textFieldStyle(.plain)
                .frame(width: proxy.size.width / 1.4)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.white))
            
            Menu {
                Text("a")
                Text("b")
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
                ForEach(categories, id: \.self) { category in
                    Button(category) {
                        
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.white))
                
                }
            }
            .padding()
        }
        .scrollIndicators(.never, axes: .horizontal)
        .frame(height: 100)
    }
    
    @ViewBuilder
    private func ProductsScrollableView() -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 130))]) {
            ForEach(Product.sampleProducs, id: \.id) { product in
                NavigationLink {
                    
                } label: {
                    VStack {
                        ZStack {
                            Rectangle().frame(width: 180, height: 160)
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "heart")
                                    .font(.system(size: 24))
                                    .padding()
                                    .frame(width: 40, height: 40)
                                    .background(Capsule().foregroundStyle(.white))
                                    .padding([.leading, .bottom], 106)
                            }
                        }
                        
                        Text(product.title)
                        Text("$\(product.price)")
                            .bold()
                        
                        LazyHStack(spacing: 1) {
                            ForEach(0...Int(product.rating), id: \.self) { num in
                                HStack {
                                    Image(systemName: "star.fill")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
