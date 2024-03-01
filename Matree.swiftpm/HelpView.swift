//
//  HelpView.swift
//  Matree
//
//  Created by Afonso Lucas on 24/02/24.
//

import SwiftUI

struct HelpView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // MARK: Title
                Text("MaTree")
                    .font(.title)
                    .bold()
                    .monospaced()
                
                Text("Matree is a calculator that demonstrates how computers work with mathematical expressions.")
                    .font(.body)
                
                Image(.matree)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 240)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                // MARK: Input Explanation
                Text("As you enter your expression in the designated field, a corresponding tree graph is dynamically generated.")
                
                Text("(Only valid expressions will result in graphs)")
                    .font(.callout)
                    .bold()
                
                HStack(spacing: 8) {
                    Image(.i1)
                        .resizable()
                        .scaledToFit()
                    
                    Image(.i2)
                        .resizable()
                        .scaledToFit()
                }
                
                // MARK: Moviment explanation
                Text("After inputting your expression, press \"Done\" to view the corresponding tree. \nYou can navigate through the tree by moving the screen and applying zoom as desired.")
                
                Text("(To restore the default position and zoom, double-tap the screen)")
                    .font(.callout)
                    .bold()
                
                HStack(spacing: 8) {
                    Image(.m1)
                        .resizable()
                        .scaledToFit()
                    
                    Image(.m3)
                        .resizable()
                        .scaledToFit()
                }
                
                // MARK: Call to action
                Text("How about entering an expression and pressing \"Solve\" to see what happens?")
                    .font(.callout)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.top, 36)
                    .padding(.bottom, 16)
                
                Button(action: { dismiss() }) {
                    Text("Try!")
                        .font(.callout)
                        .bold()
                        .foregroundStyle(Color.DefaultBlack)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color.BackgroundNodeValue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .foregroundStyle(Color.LightText)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.top)
        }
        .background(Color.DefaultBlack)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    HelpView()
}
