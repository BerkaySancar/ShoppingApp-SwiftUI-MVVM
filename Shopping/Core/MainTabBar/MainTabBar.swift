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
    case favorites
    case profile
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .favorites:
            return "Favorite"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .favorites:
            return "heart"
        case .profile:
            return "person"
        }
    }
}


struct MainTabbarView: View {
    
    @State var selectedTab = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                
                FavoritesView()
                    .tag(1)

                ProfileView()
                    .tag(2)
            }
            
            ZStack {
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
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

extension MainTabbarView {
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .white : .white)
                .frame(width: 20, height: 20)
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .white : .white)
            }
            Spacer()
        }
        .frame(width: isActive ? 120 : 60, height: 60)
        .background(isActive ? .orange : .clear)
        .cornerRadius(30)
    }
}
