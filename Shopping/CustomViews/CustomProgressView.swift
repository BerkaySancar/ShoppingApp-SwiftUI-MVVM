//
//  CustomProgressView.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .blur(radius: 500)
            VStack {
                Text("Shopping App")
                ProgressView()
                    .controlSize(.large)
            }
            .padding()
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18)
                .stroke(lineWidth: 1)
                .foregroundStyle(.gray))
        }
        .allowsHitTesting(true)
    }
}

#Preview {
    CustomProgressView()
}
