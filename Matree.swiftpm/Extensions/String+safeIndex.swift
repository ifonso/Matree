//
//  File.swift
//  
//
//  Created by Afonso Lucas on 21/02/24.
//

import Foundation


extension String {
    
    subscript(safe index: Int) -> Character? {
        guard index >= 0 && index < count else { return nil }
        return self[self.index(startIndex, offsetBy: index)]
    }
}
