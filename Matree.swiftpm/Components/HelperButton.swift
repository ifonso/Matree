//
//  HelperButtonView.swift
//
//
//  Created by Afonso Lucas on 15/02/24.
//

import SwiftUI


struct HelperButtonView: View {
    
    let label: String
    let icon: String
    
    let action: () -> Void
    
    let corners: some View = RoundedRectangle(cornerRadius: 12)
        .stroke()
        .foregroundStyle(Color.LightStroke)
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                
                Text(label)
                    .fontWeight(.medium)
                // TODO: Criar a fonte
            }
            .foregroundStyle(Color.DefaultPlaceholder)
        }
        .frame(width: 90, height: 42)
        .background(corners)
        .background(Color.BackgroundWhite)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


#Preview {
    VStack {
        HelperButtonView(label: "Story", icon: "books.vertical.fill") {}
        HelperButtonView(label: "Help", icon: "questionmark.circle.fill") {}
    }
}
