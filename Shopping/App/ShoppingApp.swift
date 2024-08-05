//
//  ShoppingApp.swift
//  Shopping
//
//  Created by Berkay Sancar on 26.07.2024.
//

import SwiftUI

@main
struct ShoppingApp: App {
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
    
    init() {
        pageControlAppearence()
        navBarAppearance()
        alertViewButtonTintAppearance()
    }
    
    private func pageControlAppearence() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .appOrange
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    private func navBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.appOrange]
        UIBarButtonItem.appearance().tintColor = UIColor.appOrange
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    private func alertViewButtonTintAppearance() {
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .appOrange
    }
}
