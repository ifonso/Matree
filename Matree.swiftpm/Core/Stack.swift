//
//  Stack.swift
//
//
//  Created by Afonso Lucas on 23/02/24.
//

import Foundation


struct Stack<T> {
    
    public init() {
        self.storage = Array<T>()
    }
    
    private var storage: Array<T>
    
    public var size: Int {
        return storage.count
    }
    
    public var isEmpty: Bool {
        return size == 0
    }
    
    public var isNotEmpty: Bool {
        return size > 0
    }
    
    // MARK: - Operations
    
    public mutating func push(_ value: T) {
        storage.append(value)
    }
    
    @discardableResult
    public mutating func pop() -> T? {
        return storage.popLast()
    }
    
    public func peek() -> T? {
        return storage.last
    }
}
