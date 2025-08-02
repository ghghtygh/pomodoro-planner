import SwiftUI

struct ScheduleView: View {
    @ObservedObject var viewModel: TaskViewModel

    var timeSlots: [Date] {
        let hours = Array(0..<24)
        let baseDate = Date()
        let calendar = Calendar.current
        return hours.compactMap { hour in
            calendar.date(bySettingHour: hour, minute: 0, second: 0, of: baseDate)
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("시간대별 작업 배치")
                .font(.title2)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(timeSlots, id: \.self) { time in
                        scheduleRow(for: time)
                    }
                }
            }
            .frame(maxHeight: 400) // 원하는 높이 설정
        }
    }

    @ViewBuilder
    private func scheduleRow(for time: Date) -> some View {
        HStack {
            Text(timeFormatter.string(from: time))
                .frame(width: 80, alignment: .leading)

            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 40)

                if let task = viewModel.tasks.first(where: {
                    Calendar.current.isDate($0.scheduledTime ?? Date.distantPast, equalTo: time, toGranularity: .hour)
                }) {
                    Text(task.title)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            }
            .onDrop(of: [.text], isTargeted: nil) { providers in
                handleDrop(providers: providers, time: time)
                return true
            }
        }
    }

    private func handleDrop(providers: [NSItemProvider], time: Date) -> Bool {
        guard let provider = providers.first else { return false }
        
        // 문자열로 추출한 UUID를 파싱하고 task에 연결
        provider.loadItem(forTypeIdentifier: "public.text", options: nil) { data, _ in
            if let data = data as? Data,
               let idStr = String(data: data, encoding: .utf8),
               let uuid = UUID(uuidString: idStr) {
                DispatchQueue.main.async {
                    if let task = viewModel.tasks.first(where: { $0.id == uuid }) {
                        viewModel.updateTask(task, withTime: time)
                    }
                }
            }
        }

        return true
    }

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
}
