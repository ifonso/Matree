//
//  TreeViewModel.swift
//  Matree
//
//  Created by Afonso Lucas on 27/02/24.
//

import Foundation


enum NodeVisulizationType {
    case `operator`
    case numeric
}

struct TreeViewModel: Identifiable {
    
    let id: UUID = UUID()
    
    let value: String
    let type: NodeVisulizationType
    
    /// [rhs, lhs]
    let children: [TreeViewModel]
    
    /// Value node initializer
    init(value: Double) {
        self.value = Self.parseNumber(value)
        self.type = .numeric
        self.children = []
    }
    
    /// Operator node initializer
    /// children [rhs, lhs]
    init(_ value: String, children: [TreeViewModel]) {
        self.value = value
        self.type = .operator
        self.children = children
    }
    
    static private func parseNumber(_ number: Double) -> String {
        return number.truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", number)
        : String(format: "%.2f", number)
    }
}
