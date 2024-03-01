import SwiftUI


@main
struct MyApp: App {
    
    @StateObject var app = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            if app.presentingScene == .simulator {
                SimulatorView(viewModel: SimulatorViewModel(parser: Parser(), 
                                                            lexer: Lexer(),
                                                            solver: Solver()),
                              shouldPresentHelp: true)
                    .preferredColorScheme(.dark)
                    .statusBarHidden()
            } else {
                StoryView()
                    .preferredColorScheme(.light)
                    .statusBarHidden()
            }
        }
    }
}
