//
//  EndView.swift
//
//
//  Created by Afonso Lucas on 25/02/24.
//

import SwiftUI

struct EndView: View {
    
    let previusPageAction: () -> Void
    let nextPageAction: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Text("Enough of theory, let's try it out! 🤠")
                    .font(.title2)
                    .foregroundStyle(Color.DefaultBlack)
            }
            
            // MARK: Buttons
            HStack {
                Button(action: previusPageAction) {
                    Text("Prev")
                        .bold()
                        .foregroundStyle(Color.LightText)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 32)
                        .background(Color.DefaultBlack)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                
                Spacer()
                
                Button(action: nextAction) {
                    Text("Go!")
                        .bold()
                        .foregroundStyle(Color.LightText)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 32)
                        .background(Color.DefaultBlack)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .foregroundStyle(Color.DefaultBlack)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func nextAction() {
        nextPageAction()
    }
}

#Preview {
    EndView(previusPageAction: {}, nextPageAction: {})
}
