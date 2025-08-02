import Cocoa
import SwiftUI
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var timer: Timer?
    
    var taskViewModel = TaskViewModel()
    var timerViewModel = PomodoroTimerViewModel()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.title = "🍅"
        updateMenu()
        startMenuRefreshTimer()
        
    }

    func startMenuRefreshTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateMenu()
        }
    }
    
    func updateMenu() {
        DispatchQueue.main.async {
            self.statusItem?.menu = self.buildMenu()
        }
    }

    private func buildMenu() -> NSMenu {
        let menu = NSMenu()

        
        let currentTask = taskViewModel.task()?.title ?? "할 일 없음"
        let formattedTime = timerViewModel.formattedTime()

        menu.addItem(NSMenuItem(title: "현재 작업: \(currentTask)", action: nil, keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "타이머: \(formattedTime)", action: nil, keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "앱 열기", action: #selector(openMainApp), keyEquivalent: ""))
        return menu
    }
    
    @objc private func openMainApp() {
        NSApp.activate(ignoringOtherApps: true)
    }
}
