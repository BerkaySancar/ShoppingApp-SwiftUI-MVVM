//
//  CustomStepperView.swift
//  Shopping
//
//  Created by Berkay Sancar on 31.07.2024.
//

import SwiftUI

struct CustomStepperView: View {
    
    @State var count: Int
    
    private func plus() {
        self.count += 1
    }
    
    private func minus() {
        if count > 1 {
            self.count -= 1
        }
    }
    
    var body: some View {
        VStack {
            Button {
                self.plus()
            } label: {
                Image(systemName: "plus")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding(.all, 6)
                    .background {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.appOrange)
                    }
            }
            .frame(width: 36, height: 36)
            
            Text("\(count)")
                .font(.title2)
                .foregroundStyle(.black)
            
            Button {
                self.minus()
            } label: {
                Image(systemName: "minus")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.appOrange)
                    }
            }
            .frame(width: 36, height: 36)
        }
    }
}

#Preview {
    CustomStepperView(count: 0)
}
