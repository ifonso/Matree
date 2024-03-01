//
//  AppState.swift
//  Matree
//
//  Created by Afonso Lucas on 29/02/24.
//

import Foundation
import SwiftUI


enum AppScene {
    case simulator
    case story
}

final class AppState: ObservableObject {
    
    public static let shared = AppState()
    private static let isFirstTimeKey = "is_first_time"
    
    @Published private(set) var isFirstTime: Bool
    @Published private(set) var presentingScene: AppScene
    
    private init() {
        let isFirstTime = UserDefaults.standard.object(forKey: Self.isFirstTimeKey) as? Bool ?? true
        
        if isFirstTime {
            UserDefaults.standard.set(true, forKey: Self.isFirstTimeKey)
        }
        
        self.isFirstTime = isFirstTime
        self.presentingScene = isFirstTime ? .story : .simulator
    }
    
    func openStory() {
        withAnimation(.spring) {
            self.presentingScene = .story
        }
    }
    
    func openSimulator() {
        withAnimation(.spring) {
            self.presentingScene = .simulator
            UserDefaults.standard.set(false, forKey: Self.isFirstTimeKey)
        }
    }
}
