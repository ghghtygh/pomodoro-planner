import SwiftUI

struct MainContentView: View {
    @StateObject var taskViewModel = TaskViewModel()

    var body: some View {
        HStack(spacing: 20) {
            ToDoListView(viewModel: taskViewModel)
                .frame(minWidth: 250, maxWidth: 400)

            ScheduleView(viewModel: taskViewModel)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(minWidth: 800, minHeight: 500)
    }
}

#Preview {
    MainContentView()
}
