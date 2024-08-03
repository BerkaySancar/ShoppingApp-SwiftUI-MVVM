//
//  CustomProgressView.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import SwiftUI

struct CustomProgressView: View {
    
    @Binding var isVisible: Bool
    
    var body: some View {
        if isVisible {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                    .blur(radius: 500)
                VStack {
                    ProgressView()
                        .controlSize(.regular)
                }
                .padding(.all, 12)
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .overlay(RoundedRectangle(cornerRadius: 18)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.appOrange))
            }
            .allowsHitTesting(true)
        }
    }
}

#Preview {
    CustomProgressView(isVisible: .constant(true))
}
