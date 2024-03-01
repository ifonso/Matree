//
//  Solver.swift
//
//
//  Created by Afonso Lucas on 23/02/24.
//

import Foundation


enum SolverError: Error {
    case invalidOperation
    case unknown
}

/// Class responsible for solving mathematical expressions represented as `Node` tree.
final class Solver {
    
    private(set) var height: Int = 0
    
    /// Recursively resolves the deepest operation of a tree if its height is greater than 1.
    /// - Parameter root: The root node of the tree representing the expression.
    /// - Returns: The height of the tree.
    @discardableResult func solve(root: Node) -> Int {
        self.height = getTreeHeight(root)
        
        if self.height > 1 {
            evaluateDeepestLeaves(from: root)
        }
        
        return self.height
    }
    
    /// Calculates the height of the tree.
    /// - Parameter root: The root node of the tree.
    /// - Returns: The height of the tree.
    func getTreeHeight(_ root: Node?) -> Int {
        guard let root = root else {
            return 0
        }
        
        let leftHeight = getTreeHeight(root.lhs)
        let rightHeight = getTreeHeight(root.rhs)
        
        return max(leftHeight, rightHeight) + 1
    }
    
    // MARK: - Utility Methods
    
    /// Recursively evaluates the deepest leaves of the tree.
    /// - Parameters:
    ///   - root: The root node of the tree.
    ///   - height: The current height while traversing the tree.
    private func evaluateDeepestLeaves(from root: Node?, height: Int = 1) {
        guard let root = root else { return }
        
        if height == self.height - 1 {
            guard case .operatorNode = root.type, let evaluatedNode = try? evaluteOperatorNode(with: root) else {
                return
            }
            root.update(node: evaluatedNode)
        }
        
        if height < self.height - 1 {
            evaluateDeepestLeaves(from: root.lhs, height: height + 1)
            evaluateDeepestLeaves(from: root.rhs, height: height + 1)
        }
    }
    
    /// Evaluates an operator node by performing the corresponding arithmetic operation.
    /// - Parameter node: The operator node to be evaluated.
    /// - Returns: The result node after performing the arithmetic operation.
    /// - Throws: `SolverError.invalidOperation` if the operation is invalid or `SolverError.unknown` if the operation is unknown.
    private func evaluteOperatorNode(with node: Node) throws -> Node {
        guard case let .operatorNode(operation) = node.type else {
            throw SolverError.invalidOperation
        }
        
        guard let lhs = node.lhs,
              let rhs = node.rhs
        else {
            throw SolverError.invalidOperation
        }
        
        guard case let .leafNode(l) = lhs.type, case let .leafNode(r) = rhs.type else {
            throw SolverError.invalidOperation
        }
        
        var result: Double
        
        switch operation {
        case "+":
            result = r + l
        case "-":
            result = r - l
        case "*":
            result = r * l
        case "/":
            result = r / l
        default:
            throw SolverError.unknown
        }
        
        return Node(result)
    }
}
