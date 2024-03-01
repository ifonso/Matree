//
//  Tree.swift
//
//
//  Created by Afonso Lucas on 15/02/24.
//

import SwiftUI


enum NodeType {
    case operatorNode(value: String)
    case leafNode(value: Double)
}

/// Class that represents a tree node
class Node {
    
    var type: NodeType
    
    var lhs: Node?
    var rhs: Node?
    
    /// Operator initializer
    /// [rhs, lhs]
    init(_ value: String,
         children: [Node]) {
        self.type = .operatorNode(value: value)
        self.lhs = children[1]
        self.rhs = children[0]
    }
    
    /// Value initializer
    init(_ value: Double) {
        self.type = .leafNode(value: value)
        self.lhs = nil
        self.rhs = nil
    }
}

extension Node {
    
    func update(node: Node) {
        self.type = node.type
        self.lhs = node.lhs
        self.rhs = node.rhs
    }
}
