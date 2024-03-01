//
//  IntroView.swift
//
//
//  Created by Afonso Lucas on 24/02/24.
//

import SwiftUI


struct IntroView: View {
    
    let nextPageAction: () -> Void
    let previusPageAction: () -> Void
    
    @State var phase: Int = 1
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 24) {
                // Callout
                if phase >= 1 {
                    Text("Computers are dumb! 🫤")
                        .bold()
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack(alignment: .leading) {
                    if phase >= 2 {
                        Text("So why do we rely on them so much to work on complex mathematical problems?")
                    }
                    
                    if phase >= 3 {
                        Text("Because they are fast.")
                    }
                }
                
                if phase >= 4 {
                    Text("Indeed, computers cannot understand mathematics like we do. Processors, concerning arithmetic, can only perform simple operations such as addition, subtraction, multiplication, and division.")
                }
                
                if phase >= 5 {
                    Text("So how do they manage to solve complex expressions? Let's see.")
                }
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
    IntroView(nextPageAction: {}, previusPageAction: {})
}
