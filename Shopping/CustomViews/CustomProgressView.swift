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
                Text("......................")
            }
            .padding()
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .allowsHitTesting(true)
    }
}

#Preview {
    CustomProgressView()
}
