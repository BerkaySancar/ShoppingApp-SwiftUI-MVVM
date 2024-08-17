//
//  ProfileView.swift
//  Shopping
//
//  Created by Berkay Sancar on 31.07.2024.
//

import SwiftUI

struct ProfileView: View {
   
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            List {
                Section {
                    TopSection()
                } header: {
                    Text("User")
                        .font(.headline)
                        .foregroundStyle(.appOrange)
                }
                
                Section {
                    InfosSection()
                }
                
                Section("") {
                    LogOutRemoveSection()
                }
            }
            
            CustomProgressView(isVisible: $viewModel.showActivity)
        }
        .onAppear {
            viewModel.getCompletedOrders()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.errorMessage))
        }
    }
}

extension ProfileView {
    
    @ViewBuilder
    private func TopSection() -> some View {
        HStack {
            Spacer()
            VStack(spacing: 16) {
                AsyncImage(url: .init(string: viewModel.user?.image ?? "")) { image in
                    image.image?.resizable()
                        .scaledToFit()
                }
                .frame(width: 80, height: 80)
                
                Text("\(viewModel.user?.firstName ?? "") \(viewModel.user?.lastName ?? "")")
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func InfosSection() -> some View {
        Label {
            Text(viewModel.user?.email ?? "")
        } icon: {
            Image(systemName: "mail")
                .foregroundStyle(.appOrange)
        }
        
        Label {
            Text("\(viewModel.user?.firstName ?? "") \(viewModel.user?.lastName ?? "")")
        } icon: {
            Image(systemName: "textformat.size")
                .foregroundStyle(.appOrange)
        }
        
        Label {
            Text(viewModel.user?.gender ?? "")
        } icon: {
            Image(systemName: "figure.dress.line.vertical.figure")
                .foregroundStyle(.appOrange)
        }
        
        DisclosureGroup {
            Text(
"""
\(viewModel.user?.address.city ?? ""), \(viewModel.user?.address.country ?? "")
\(viewModel.user?.address.address ?? "")
"""
            )
        } label: {
            Label {
                Text("Address")
            } icon: {
                Image(systemName: "map")
                    .foregroundStyle(.appOrange)
            }
        }
        
        DisclosureGroup {
            Text(
"""
CardNumber: \(viewModel.user?.bank.cardNumber ?? "")
ExpireDate: \(viewModel.user?.bank.cardExpire ?? "")
Iban: \(viewModel.user?.bank.iban ?? "")
Currency: \(viewModel.user?.bank.currency ?? "")
"""             )
        } label: {
            Label {
                Text("Card")
            } icon: {
                Image(systemName: "creditcard")
                    .foregroundStyle(.appOrange)
            }
        }
        
        DisclosureGroup {
            Text(viewModel.purchasedProducts())
        } label: {
            Label {
                Text("Recently Purchased Products")
            } icon: {
                Image(systemName: "cart")
                    .foregroundStyle(.appOrange)
            }
        }
    }
    
    @ViewBuilder
    private func LogOutRemoveSection() -> some View {
        Button {
            viewModel.signOutTapped {
                coordinator.popToRoot()
            }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundStyle(.red)
                    .font(.title3)
                    .padding(.leading, 4)
                
                Text("Sign Out")
                    .foregroundStyle(.black)
            }
        }
        
        Button {
            // 
        } label: {
            HStack(spacing: 18) {
                Image(systemName: "trash")
                    .foregroundStyle(.red)
                    .font(.title3)
                    .padding(.leading, 4)
                
                Text("Delete Account")
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(Coordinator())
}
