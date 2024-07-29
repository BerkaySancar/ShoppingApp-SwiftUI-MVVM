//
//  ContentView.swift
//  Shopping
//
//  Created by Berkay Sancar on 26.07.2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                TopView()
                InputView()
                CustomProgressView(isVisible: $viewModel.showActivity)
            }
            .background(Color.appGrayBackground)
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                MainTabbarView()
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $viewModel.showSignup) {
                SignUpView()
                    .navigationBarBackButtonHidden()
            }
            .alert(isPresented: $viewModel.isPresentAlert) {
                Alert(title: Text(viewModel.errorMessage))
            }
        }
    }
}

//MARK: - TopView
extension LoginView {
    @ViewBuilder
    private func TopView() -> some View {
        GeometryReader { proxy in
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .ignoresSafeArea()
                    .foregroundStyle(Color.appPrimaryColor)
                    .frame(width: proxy.size.width, height: proxy.size.height / 2.4)
                
                Image(systemName: "cart")
                    .font(.system(size: 100))
                    .foregroundStyle(.background)
            }
        }
    }

//MARK: - InputView
    @ViewBuilder
    private func InputView() -> some View {
        VStack {
            Text("Welcome")
                .font(.title.bold())
                .foregroundStyle(.gray)
            TextField("",
                      text: $viewModel.username,
                      prompt: Text("Username"))
            .modifier(AppTextFieldModifier())
            
            SecureField("",
                        text: $viewModel.password,
                        prompt: Text("Password"))
                .modifier(AppTextFieldModifier())
            
            Button {
                viewModel.loginTapped()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 120, height: 48)
                        .foregroundStyle(Color.appPrimaryColor)
                    Text("Login")
                        .foregroundStyle(.background)
                        .font(.title3)
                }
            }
            .padding(.top, 26)
            
            Button {
                viewModel.signUpTapped()
            } label: {
                HStack {
                    Text("Don't have an account?")
                    Text("Sign up.")
                        .bold()
                }
                .font(.callout)
                .foregroundStyle(.gray)
            }
            .padding(.top, 10)
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }
}

#Preview {
    LoginView()
}
