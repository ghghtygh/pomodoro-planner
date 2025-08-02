import SwiftUI

struct ToDoListView: View {
    @ObservedObject var viewModel: TaskViewModel
    @State private var newTask = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("TO DO LIST")
                .font(.title2)

            HStack {
                TextField("할 일을 입력하세요", text: $newTask)
                Button("추가") {
                    viewModel.addTask(title: newTask)
                    newTask = ""
                }
            }

            List {
                ForEach(viewModel.tasks) { task in
                    Text(task.title)
                        .onDrag {
                            NSItemProvider(object: task.id.uuidString as NSString)
                        }
                }
            }
        }
    }
}
