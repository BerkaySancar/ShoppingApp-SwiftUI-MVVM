//
//  SplashView.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import SwiftUI

struct SplashView: View {
    
    @StateObject private var viewModel = SplashViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                ZStack {
                    Circle()
                        .foregroundStyle(.appOrange)
                        .frame(width: 300)
                    
                    Image(systemName: "cart")
                        .foregroundStyle(.white)
                        .font(.system(size: 100))
                }
                Spacer()
                Text("© Berkay Sancar 2024 ©")
                    .font(.callout)
            }
            .onAppear {
                viewModel.manageSplashAction()
            }
            .alert(isPresented: $viewModel.presentConnectionAlert) {
                Alert(
                    title: Text("No internet connection."),
                    message: Text("Try again."),
                    dismissButton: .cancel(Text("Done"), action: { viewModel.manageSplashAction() }))
            }
            .navigationDestination(isPresented: $viewModel.isAuthUser) {
                MainTabbarView()
                    .navigationBarBackButtonHidden()
            }
            .fullScreenCover(isPresented: $viewModel.shouldLogin) {
                LoginView()
            }
        }
    }
}

#Preview {
    SplashView()
}
