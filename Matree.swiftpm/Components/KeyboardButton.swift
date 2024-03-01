//
//  KeyboardButton.swift
//
//
//  Created by Afonso Lucas on 23/02/24.
//

import SwiftUI

struct KeyboardButtonView: View {
    
    let label: String
    let action: (String) -> Void
    
    var body: some View {
        Button {
            action(self.label)
        } label: {
            Text(label)
                .foregroundStyle(.blue)
                .font(.title3)
                .frame(width: 24, height: 32)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    VStack {
        KeyboardButtonView(label: "(", action: { _ in })
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.black)
}
