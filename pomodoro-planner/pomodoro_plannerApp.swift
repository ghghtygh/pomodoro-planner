import SwiftUI

@main
struct pomodoro_plannerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MainContentView()
        }
    }
}
