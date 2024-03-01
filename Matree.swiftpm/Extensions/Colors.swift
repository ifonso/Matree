//
//  Colors.swift
//  Matree
//
//  Created by Afonso Lucas on 15/02/24.
//

import SwiftUI


extension Color {
    
    // MARK: - Backgrounds
    
    static var BackgroundNodeValue: Color {
        Color(hex: 0xE3C9FE)
    }
    
    static var BackgroundDarkWhite: Color {
        Color(hex: 0xE7E7E7)
    }
    
    static var BackgroundWhite: Color {
        Color(hex: 0xFFFFFF)
    }
    
    static var BackgroundGray: Color {
        Color(hex: 0xE7E7E7)
    }
    
    // MARK: - Text
    
    static var LightText: Color {
        Color(hex: 0xFFFFFF)
    }
    
    static var DarkText: Color {
        Color(hex: 0x000000)
    }
    
    static var GrayText: Color {
        Color(hex: 0x8E8E8E)
    }
    
    // MARK: - Etc
    
    static var DefaultPlaceholder: Color {
        Color(hex: 0x8E8E8E)
    }
    
    static var LightStroke: Color {
        Color(hex: 0xE3E3E3)
    }
    
    static var DefaultBlack: Color {
        Color(hex: 0x000000)
    }
}


extension Color {
    
    init(hex: UInt, alpha: Double = 1) {
        self.init(.sRGB,
                  red: Double((hex >> 16) & 0xff) / 255,
                  green: Double((hex >> 08) & 0xff) / 255,
                  blue: Double((hex >> 00) & 0xff) / 255,
                  opacity: alpha
        )
    }
}
