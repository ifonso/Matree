//
//  TreeSolveView.swift
//
//
//  Created by Afonso Lucas on 25/02/24.
//

import SwiftUI


struct TreeSolveView: View {
    
    let nextPageAction: () -> Void
    let previusPageAction: () -> Void
    
    @State var phase: Int = 1
    
    var body: some View {
        ZStack {
            VStack {
                Text("Let's solve **(2+8/2) - 4*2** the way a computer would:")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top, 64)
            
            if phase == 1 {
                Image(.tree1)
                    .resizable()
                    .scaledToFit()
                
                Text("Starting with the depest leafs **8/2**.")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(.bottom, 100)
            }
            
            if phase == 2 {
                Image(.tree2)
                    .resizable()
                    .scaledToFit()
                
                Text("**2+4** and **4*2** have the save level of priority so we can solve both.")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(.bottom, 100)
            }
            
            if phase >= 3 {
                Image(.tree3)
                    .resizable()
                    .scaledToFit()
                
                Text("Now we have just **6-8** and the result of our tree is **-2**.")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(.bottom, 100)
            }
            
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
                    Text("Next")
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
        .onAppear {
            phase = 1
        }
    }
    
    func nextAction() {
        if phase == 3 {
            nextPageAction()
        } else {
            withAnimation(.easeIn(duration: 0.5)) {
                phase += 1
            }
        }
    }
}

#Preview {
    TreeSolveView(nextPageAction: {}, previusPageAction: {})
}
