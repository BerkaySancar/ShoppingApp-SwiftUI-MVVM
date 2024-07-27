//
//  SignUpView.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SignUpViewModel()
 
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                InputView()
                Spacer()
                Spacer()
                BottomView()
            }
            
            if viewModel.showActivity {
                CustomProgressView()
            }
        }
        .background(Color.appGrayBackground)
        .alert(isPresented: $viewModel.showAlert) {
            switch viewModel.activeAlert {
            case .userCreated:
                Alert(
                    title: Text("User successfully created."),
                    message: Text("Please login."),
                    dismissButton: .cancel(Text("Done"), action: {
                        dismiss()
                    })
                )
            case .emptyInfo:
                Alert(title: Text(viewModel.errorMessage))
            case .userNotCreated:
                Alert(title: Text(viewModel.errorMessage))
            }
        }
    }
}

//MARK: - InputView
extension SignUpView {
    @ViewBuilder
    private func InputView() -> some View {
        VStack {
            Text("Welcome")
                .font(.title).bold()
                .foregroundStyle(.gray)
                .padding(.top, 10)
            
            TextField("", text: $viewModel.firstName, prompt: Text("First Name"))
                .modifier(AppTextFieldModifier())
            
            TextField("", text: $viewModel.lastName, prompt: Text("Last Name"))
                .modifier(AppTextFieldModifier())
            
            TextField("", text: $viewModel.username, prompt: Text("Username"))
                .modifier(AppTextFieldModifier())
            
            TextField("", text: $viewModel.email, prompt: Text("Email"))
                .modifier(AppTextFieldModifier())
            
            SecureField("", text: $viewModel.password, prompt: Text("Password"))
                .modifier(AppTextFieldModifier())
            
            Button {
                viewModel.createUserTapped()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 120, height: 48)
                        .foregroundStyle(Color.appPrimaryColor)
                    Text("Create")
                        .foregroundStyle(.background)
                        .font(.title3)
                }
            }
            .padding(.top, 26)
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                    Text("Log in.")
                        .bold()
                }
                .font(.callout)
                .foregroundStyle(.gray)
            }
            .padding(.top, 10)
            .padding(.bottom, 10)
        }
        .padding(.horizontal)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
    
//MARK: - Bottom View
    @ViewBuilder
    private func BottomView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color.appPrimaryColor)
                .ignoresSafeArea()
                .frame(height: 20)
            
            HStack(spacing: 0) {
                Image(systemName: "cart")
                    .padding(.horizontal, 30)
               
                Text("Shopping App")
                
                Image(systemName: "cart")
                    .padding(.horizontal, 30)
                  
            }
            .padding(.top, 30)
            .foregroundStyle(.background)
            .font(.system(size: 18))
        }
        .frame(height: 20)
    }
}


#Preview {
    SignUpView()
}
