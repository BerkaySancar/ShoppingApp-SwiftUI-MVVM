//
//  ContentView.swift
//  Shopping
//
//  Created by Berkay Sancar on 26.07.2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        ZStack {
            TopView()
            InputView()
            CustomProgressView(isVisible: $viewModel.showActivity)
        }
        .background(Color.appGrayBackground)
        .alert(isPresented: $viewModel.isPresentAlert) {
            Alert(title: Text(viewModel.errorMessage))
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
            
            CustomButton(
                imageName: nil,
                buttonText: "Login",
                action: {
                    viewModel.loginTapped { isSuccess in
                        if isSuccess {
                            coordinator.push(.tabBar)
                        }
                    }
                },
                imageTint: nil,
                width: 100
            )
            .padding(.top)
            
            Button {
                coordinator.push(.signup)
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
        .environmentObject(Coordinator())
}
