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
        GeometryReader { proxy in
            VStack {
                RoundedRectangle(cornerRadius: 30)
                    .ignoresSafeArea()
                    .foregroundStyle(.orange.opacity(0.75))
                    .frame(width: proxy.size.width, height: proxy.size.height / 2.5)
                
                Image(systemName: "cart")
                    .font(.system(size: 100))
                    .foregroundStyle(.white)
                    .padding(.vertical, -200)
                

                VStack {
                    Group {
                        Text("Welcome")
                            .padding(.top, 40)
                            .font(.title.bold())
                        TextField("Username",
                                  text: $viewModel.username,
                                  prompt: Text("Enter your username..."))
                            .modifier(AppTextFieldModifier())
                        
                        SecureField("Password", text: $viewModel.password, prompt: Text("Enter your password..."))
                            .modifier(AppTextFieldModifier())
                            .padding(.bottom, 60)
                    }
                    .padding(.horizontal)
                }
                .background(RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.white))
                .padding(.all, 36)
                .padding(.vertical, -100)
                
                
                Button {
                    //action
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 120, height: 48)
                            .foregroundStyle(.orange.opacity(1))
                        Text("Login")
                            .foregroundStyle(.white)
                            .font(.title3)
                    }
                }
                .padding(.top, 26)
            }
        }
        .background(.gray.opacity(0.2))
    }
}

#Preview {
    LoginView()
}
