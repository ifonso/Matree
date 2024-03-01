//
//  StoryView.swift
//
//
//  Created by Afonso Lucas on 24/02/24.
//

import SwiftUI


struct StoryView: View {
    
    @State var page: Int = 1
    
    var body: some View {
        TabView(selection: $page) {
            IntroView(
                nextPageAction: nextPage,
                previusPageAction: prevPage
            )
            .tag(1)
            
            TreeIntroView(
                nextPageAction: nextPage,
                previusPageAction: prevPage
            )
            .tag(2)
            
            TreeSolveView(
                nextPageAction: nextPage,
                previusPageAction: prevPage
            )
            .tag(3)
            
            EndView(previusPageAction: prevPage) {
                AppState.shared.openSimulator()
            }
            .tag(4)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .background(Color.BackgroundWhite)
    }
    
    func nextPage() {
        guard page < 5 else { return }
        
        withAnimation(.spring) {
            page += 1
        }
    }
    
    func prevPage() {
        guard page > 1 else { return }
        
        page -= 1
    }
}

#Preview {
    StoryView()
}
