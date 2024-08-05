//
//  CustomButton.swift
//  Shopping
//
//  Created by Berkay Sancar on 5.08.2024.
//

import SwiftUI

struct CustomButton: View {
    let imageName: String?
    let buttonText: String
    let action: () -> Void
    let imageTint: Color?
    let width: CGFloat
    
    var body: some View {
        HStack(spacing: 4) {
            if let imageName,
               let imageTint{
                Image(systemName: imageName)
                    .foregroundStyle(imageTint)
            }
            Button(buttonText, action: action)
        }
        .frame(minWidth: width)
        .foregroundStyle(.white)
        .padding(.vertical, 16)
        .padding(.horizontal, 10)
        .background(RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(.appOrange))
    }
}
