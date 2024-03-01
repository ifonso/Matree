//
//  SimulatorViewModel.swift
//  Matree
//
//  Created by Afonso Lucas on 23/02/24.
//

import Foundation
import Combine
import SwiftUI


final class SimulatorViewModel: ObservableObject {
    
    /// The mathematical expression entered by the user.
    @Published var expression: String = ""
    /// The tree representation of the mathematical expression.
    @Published var tree: TreeViewModel? = nil
    
    private var ast: Node? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    private let parser: Parser
    private let lexer: Lexer
    private let solver: Solver
    
    init(parser: Parser, lexer: Lexer, solver: Solver) {
        self.parser = parser
        self.lexer = lexer
        self.solver = solver
        setupBindings()
    }
    
    func customEntryClicked(_ label: String) {
        expression += label
    }
    
    func didChangeExpression(exp: String) {
        let expression = exp.replacingOccurrences(of: ",", with: ".")

        guard let tokens = try? lexer.getTokens(expression: expression),
              let tree = try? parser.parse(expression: tokens)
        else { return }
        
        self.ast = tree
        updateTree(tree: tree)
    }
    
    func solve(_ value: String) {
        guard let ast = self.ast else { return }
        solver.solve(root: ast)
        updateTree(tree: ast)
    }
    
    // MARK: - Utility methods
    
    private func convertIntoTreeViewModel(root: Node) -> TreeViewModel {
        switch root.type {
        case .leafNode(let number):
            return TreeViewModel(value: number)
            
        case .operatorNode(let operation):
            guard let lhs = root.lhs,
                  let rhs = root.rhs
            else {
                fatalError("invalid tree structure")
            }
            
            return TreeViewModel(
                operation,
                children: [convertIntoTreeViewModel(root: rhs), convertIntoTreeViewModel(root: lhs)])
        }
    }
    
    private func setupBindings() {
        $expression.sink { exp in
            self.didChangeExpression(exp: exp)
        }
        .store(in: &cancellables)
    }
    
    private func updateTree(tree: Node) {
        let treeViewModel = convertIntoTreeViewModel(root: tree)
        Task {
            await MainActor.run {
                withAnimation(.easeIn) {
                    self.tree = treeViewModel
                }
            }
        }
    }
}
