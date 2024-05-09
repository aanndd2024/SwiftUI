//
//  TaskDetailsView.swift
//  MyTask
//
//  Created by Anand Yadav on 08-05-2024.
//

import SwiftUI

struct TaskDetailsView: View {
    @ObservedObject var taskViewModel: TaskViewModel
    @Binding var showTaskDetailsView: Bool
    @Binding var selectedTask:Task
    @Binding var refreshTaskList:Bool
    @State var showDeleteAlert:Bool = false

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Task Name")) {
                    TextField("Task Name", text:$selectedTask.name)
                    TextEditor(text: $selectedTask.desc)
                    Toggle("Mark Completed", isOn: $selectedTask.isCompleted)
                }
                
                Section(header: Text("Task date/time")){
                    DatePicker("Task Date", selection: $selectedTask.finishedDate)
                }
                
                Section {
                    Button {
                        showDeleteAlert.toggle()
//                        print("Delete Task")
                    } label: {
                        Text("Delete")
                            .font(.title2)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment:.center)
                    }.alert("Delete Task?", isPresented: $showDeleteAlert) {
                        Button {
                            showDeleteAlert.toggle()
                        }label: {
                            Text("No")
                        }
                        Button {
                            if(taskViewModel.deleteTask(task: selectedTask)) {
                                showTaskDetailsView.toggle()
                                refreshTaskList.toggle()
                            }
                        }label: {
                            Text("Yes")
                        }
                    } message: {
                        Text("Would you like to delete task \(selectedTask.name)?")
                    }

                }
            }.navigationTitle("Task Details")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            print("Cancel Button clicked")
                            showTaskDetailsView = false
                        } label: {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Add Button clicked")
                            if(taskViewModel.updateTask(task: selectedTask)) {
                                showTaskDetailsView.toggle()
                                refreshTaskList.toggle()
                            }
                        } label: {
                            Text("Update")
                        }
                    }
                }
        }
    }
}

#Preview {
    TaskDetailsView(taskViewModel: TaskViewModel(), showTaskDetailsView: .constant(false), selectedTask: .constant(Task.createMockTask().first!), refreshTaskList: .constant(false))
}
