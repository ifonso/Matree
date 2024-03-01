//
//  File.swift
//  
//
//  Created by Afonso Lucas on 15/02/24.
//

import SwiftUI


enum InputState {
    case `default`
    case keyboard
}

struct SimulatorInput: View {
    
    @Binding var input: String
    @State var state: InputState = .default
    
    var action: (String) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                TextField("",
                          text: $input,
                          onEditingChanged: changeState
                )
                .keyboardType(.decimalPad)
                .kerning(1)
                .foregroundStyle(Color.LightText)
                .font(.system(size: 16,
                              weight: .medium,
                              design: .monospaced)
                )
                .placeholder(when: input.isEmpty) {
                    Text("Your expression...")
                        .foregroundStyle(Color.LightText)
                        .font(.system(size: 16,
                                      weight: .regular,
                                      design: .monospaced)
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.DefaultBlack)
            
            Button(action: exec) {
                Text(state == .default
                     ? "SOLVE"
                     : "CLEAR"
                )
                .font(.system(size: 14,
                              weight: .bold,
                              design: .monospaced)
                )
                .foregroundStyle(Color.DefaultBlack)
                .padding(.horizontal, 14)
                .frame(maxHeight: .infinity)
                .background(state == .default
                            ? Color.BackgroundNodeValue
                            : Color.BackgroundGray
                )
            }
        }
        .frame(width: 320, height: 42)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    func exec() {
        if state == .default {
            action(input)
        } else {
            input = ""
        }
    }
    
    func changeState(focused: Bool) {
        withAnimation(.spring()) {
            self.state = focused ? .keyboard : .default
        }
    }
}

private extension View {
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: .leading) {
            placeholder().opacity(shouldShow ? 0.7 : 0)
            self
        }
    }
}


#Preview {
    let input = State(wrappedValue: "(5+5)")
    
    return SimulatorInput(input: input.projectedValue) { text in }
}
