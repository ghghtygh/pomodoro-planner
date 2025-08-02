import Foundation
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []

    func addTask(title: String) {
        tasks.append(Task(title: title))
    }

    func updateTask(_ task: Task, withTime time: Date?) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            var updatedTask = task
            updatedTask.scheduledTime = time
            tasks[index] = updatedTask
        }
    }
}

extension TaskViewModel {
    func task(forCurrentHour date: Date = Date()) -> Task? {
        return tasks.first {
            guard let scheduled = $0.scheduledTime else { return false }
            return Calendar.current.isDate(scheduled, equalTo: date, toGranularity: .hour)
        }
    }
}
