//
//  SimulatorView.swift
//  Matree
//
//  Created by Afonso Lucas on 15/02/24.
//

import SwiftUI


struct SimulatorView: View {
    
    @ObservedObject private var vm: SimulatorViewModel
    
    // MARK: Position
    @State private var offset: CGSize = .zero
    @State private var CScale: CGFloat = 1
    @State private var LScale: CGFloat = 1
    
    // MARK: Scree State
    @FocusState private var focusExpressionField: Bool
    @State private var presentHelp: Bool = false
    
    init(viewModel: SimulatorViewModel, shouldPresentHelp present: Bool) {
        self.vm = viewModel
        self.presentHelp = present
    }
    
    var body: some View {
        let drag = DragGesture()
            .onChanged { value in
                withAnimation(.spring()) {
                    offset = value.translation
                }
            }
        
        let magnification = MagnificationGesture()
            .onChanged { value in
                let delta = value / self.LScale
                self.LScale = value
                
                let newScale = self.CScale * delta
                guard newScale < 1.5 && newScale > 0.4 else { return }
                
                self.CScale = newScale
            }
            .onEnded { _ in
                self.LScale = 1
            }
        
        return ZStack(alignment: .topLeading) {
            // MARK: Graph
            if let tree = vm.tree {
                NodeStructureView(node: tree) { node in
                    Text("\(node.value)")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundStyle(
                            node.type == .numeric
                            ? Color.DefaultBlack
                            : Color.LightText
                        )
                        .frame(width: 50, height: 50)
                        .background(
                            Circle()
                                .stroke()
                                .foregroundStyle(
                                    node.type == .numeric
                                    ? Color.DefaultBlack
                                    : Color.clear
                                )
                        )
                        .background(
                            Circle()
                                .fill(
                                    node.type == .numeric
                                    ? Color.BackgroundNodeValue
                                    : Color.DefaultBlack
                                )
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .frame(alignment: .center)
                .scaleEffect(CScale)
                .offset(offset)
            }
            
            // MARK: Buttons
            VStack(spacing: 12) {
                HelperButtonView(
                    label: "Story",
                    icon: "books.vertical.fill"
                ) {
                    AppState.shared.openStory()
                }
                
                HelperButtonView(
                    label: "Help",
                    icon: "questionmark.circle.fill"
                ) {
                    presentHelp = true
                }
            }
            .padding(.leading, 20)
            
            // MARK: Input
            VStack {
                Spacer()
                SimulatorInput(input: $vm.expression, action: vm.solve)
                    .focused($focusExpressionField)
                    .padding(.bottom, 16)
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) { toolbarButtons }
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.BackgroundWhite)
        .onAppear {
            withAnimation(.spring) {
                presentHelp = true
            }
        }
        .gesture(drag)
        .gesture(magnification)
        .onTapGesture(count: 2) {
            withAnimation(.spring()) {
                offset = .zero
                CScale = 1
                LScale = 0
            }
        }
        .sheet(isPresented: $presentHelp) {
            HelpView()
        }
    }
    
    var toolbarButtons: some View {
        HStack {
            HStack(spacing: 0) {
                KeyboardButtonView(label: "(", action: vm.customEntryClicked)
                KeyboardButtonView(label: ")", action: vm.customEntryClicked)
                KeyboardButtonView(label: "+", action: vm.customEntryClicked)
                KeyboardButtonView(label: "-", action: vm.customEntryClicked)
                KeyboardButtonView(label: "*", action: vm.customEntryClicked)
                KeyboardButtonView(label: "/", action: vm.customEntryClicked)
            }
            
            Spacer()
            
            Button {
                focusExpressionField = false
            } label: {
                Text("Done")
                    .foregroundStyle(.blue)
                    .frame(height: 32)
                    .padding(.horizontal, 8)
            }
        }
        .padding(8)
    }
}
