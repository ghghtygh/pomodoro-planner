import Foundation

class PomodoroTimerViewModel: ObservableObject {
    @Published var remainingTime: Int = 25 * 60
    private var timer: Timer?

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func formattedTime() -> String {
        String(format: "%02d:%02d", remainingTime / 60, remainingTime % 60)
    }
}
