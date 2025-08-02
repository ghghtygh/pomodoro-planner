import Foundation

struct Task: Identifiable, Codable, Hashable {
    var id: UUID
    var title: String
    var scheduledTime: Date?

    init(id: UUID = UUID(), title: String, scheduledTime: Date? = nil) {
        self.id = id
        self.title = title
        self.scheduledTime = scheduledTime
    }
}
