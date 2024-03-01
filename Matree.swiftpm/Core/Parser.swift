//
//  Parser.swift
//
//
//  Created by Afonso Lucas on 23/02/24.
//

import Foundation


enum ParsingError: Error {
    case invalidNumber
    case invalidOperator
    case emptyExpression
    case invalidExpression
    case unkown
}

/// Class responsible for parsing mathematical expressions into `Node` trees.
final class Parser {
    
    /// Parses the expression represented as an array of tokens and constructs a tree structure.
    /// - Parameter expression: The expression to parse as an array of tokens.
    /// - Returns: The root node of the constructed tree.
    /// - Throws:
    ///   - `ParsingError.emptyExpression` if the expression is empty.
    ///   - `ParsingError.unknown` if an unknown error occurs during parsing.
    func parse(expression: [Token]) throws -> Node {
        guard expression.count > 0 else {
            throw ParsingError.emptyExpression
        }
        
        var temp = Stack<Node>()
        var operatorsStack = Stack<Token>()
        
        try expression.forEach { token in
            if token.type == .number {
                temp.push(try createNumberNode(token))
            }
            
            if token.type == .operator {
                while operatorsStack.isNotEmpty &&
                      operatorsStack.peek()?.type == .operator &&
                      precedence(operatorsStack.peek()) >= precedence(token)
                {
                    try createNode(operators: &operatorsStack, temp: &temp)
                }
                // Adding new token to operator stack
                operatorsStack.push(token)
            }
            
            if token.type == .leftBracket {
                operatorsStack.push(token)
            }
            
            if token.type == .rightBracket {
                while operatorsStack.isNotEmpty &&
                      operatorsStack.peek()?.type != .leftBracket
                {
                    try createNode(operators: &operatorsStack, temp: &temp)
                }
                // Removing "("
                operatorsStack.pop()
            }
        }
        
        // Cleaning operator stack
        while operatorsStack.isNotEmpty {
            try createNode(operators: &operatorsStack, temp: &temp)
        }
        
        // temp should have only one value with our tree
        guard temp.size == 1, let tree = temp.pop() else {
            throw ParsingError.unkown
        }
        
        return tree
    }

    // MARK: - Utility Methods
    
    /// Creates an operator node and pushes it to the temporary stack.
    /// - Parameters:
    ///   - operators: The stack containing operators.
    ///   - temp: The stack containing nodes.
    /// - Throws: `ParsingError.invalidExpression` if the expression is invalid.
    private func createNode(operators: inout Stack<Token>, temp: inout Stack<Node>) throws {
        guard
            let ops = operators.pop(),
            let lhs = temp.pop(),
            let rhs = temp.pop()
        else {
            throw ParsingError.invalidExpression
        }
        // Adding new operator node to temp stack
        temp.push(try createOperatorNode(ops, children: [rhs, lhs]))
    }
    
    private func createNumberNode(_ value: Token) throws -> Node {
        guard let number = Double(value.value) else {
            throw ParsingError.invalidNumber
        }
        
        return Node(number)
    }
    
    private func createOperatorNode(_ value: Token, children: [Node]) throws -> Node {
        guard "+-/*".contains(value.value) else {
            throw ParsingError.invalidOperator
        }
        
        return Node(value.value, children: children)
    }
    
    /// Determines the precedence of the given operator token.
    /// - Parameter token: The operator token.
    /// - Returns: The precedence value of the operator.
    private func precedence(_ token: Token?) -> Int {
        guard let t = token, t.type == .operator else { return 0 }
        
        switch t.value {
        case "+", "-":
            return 1
        case "*", "/":
            return 2
        default:
            return 0
        }
    }
}
