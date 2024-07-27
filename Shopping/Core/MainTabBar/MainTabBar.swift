//
//  MainTabBar.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import Foundation
import SwiftUI

//MARK: https://github.com/muhammadabbas001/CustomTabbarSwiftUI/blob/main/CustomTabbarSwiftUI/Main/MainTabbedView.swift

enum TabbedItems: Int, CaseIterable {
    case home = 0
    case cart
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .cart:
            return "Cart"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .cart:
            return "cart"
        }
    }
}


struct MainTabbarView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                
                CartView()
                    .tag(1)
            }
            
            ZStack{
                HStack {
                    ForEach((TabbedItems.allCases), id: \.self) { item in
                        Button {
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .background(.appOrange)
            .cornerRadius(35)
            .padding(.horizontal, 26)
        }
    }
}


extension MainTabbarView {
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .white : .gray)
                .frame(width: 20, height: 20)
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .white : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? 280 : 60, height: 60)
        .background(isActive ? .appOrange : .clear)
        .cornerRadius(30)
    }
}
