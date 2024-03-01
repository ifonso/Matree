//
//  TreeIntroView.swift
//
//
//  Created by Afonso Lucas on 24/02/24.
//

import SwiftUI


struct TreeIntroView: View {
    
    let nextPageAction: () -> Void
    let previusPageAction: () -> Void
    
    @State var phase: Int = 1
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                if phase >= 1 && phase < 4 {
                    Text("When we see an expression like:")
                    
                    Text("1+(2*3)")
                        .bold()
                        .monospaced()
                }
                
                if phase >= 2 && phase < 4 {
                    VStack(alignment: .leading) {
                        Text("To solve it, we recall the **PEMDAS** rule.")
                        
                        Text("(parentheses, exponential, multiplication, division, addition, and subtraction) ")
                            .italic()
                            .opacity(0.5)
                    }
                }
                
                if phase >= 3 {
                    Text("But for computers, this is just a set of characters that doesn't hold much meaning. The way they structure the expression in memory is through an abstract sintaxe tree:")
                }
                
                if phase >= 4 {
                    Image(.opTree)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                if phase >= 5 {
                    Text("The priority of operations follows the level of the tree, that is, the deepest nodes (at the lower levels) have higher priority.")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
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
        if phase == 5 {
            nextPageAction()
        } else {
            withAnimation(.easeIn(duration: 0.5)) {
                phase += 1
            }
        }
    }
}

#Preview {
    TreeIntroView(nextPageAction: {}, previusPageAction: {})
}
