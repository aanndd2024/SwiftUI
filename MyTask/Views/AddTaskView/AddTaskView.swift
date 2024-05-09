//
//  AddTaskView.swift
//  MyTask
//
//  Created by Anand Yadav on 08-05-2024.
//

import SwiftUI

struct AddTaskView: View {
    
    @ObservedObject var taskViewModel: TaskViewModel
    @State private var taskToAdd:Task = Task(id: 0, name: "", desc: "", isCompleted: false, finishedDate: Date())
    @Binding var shouldAddTaskView:Bool
    @Binding var refreshTaskList:Bool
    let dateRange: ClosedRange<Date> = {
            let calendar = Calendar.current
        let currDateComponent = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date())
        let startComponents = DateComponents(year: currDateComponent.year, month: currDateComponent.month, day: currDateComponent.day, hour: currDateComponent.hour, minute: currDateComponent.minute)
            let endComponents = DateComponents(year: 2024, month: 12, day: 31)
            return calendar.date(from:startComponents)! ... calendar.date(from:endComponents)!
        }()
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Task Name")) {
                    TextField("Task Name", text:$taskToAdd.name)
                    TextEditor(text: $taskToAdd.desc)
                }
                
                Section(header: Text("Task date/time")){
                    DatePicker("Task Date", selection: $taskToAdd.finishedDate, in:dateRange)
                }
            }.navigationTitle("Add Task")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            print("Cancel Button clicked")
                            shouldAddTaskView = false
                        } label: {
                            Text("Cancel")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Add Button clicked")
                            if(taskViewModel.addTask(task: taskToAdd)) {
                                shouldAddTaskView.toggle()
                                refreshTaskList.toggle()
                            }
                        } label: {
                            Text("Add")
                        }.disabled(taskToAdd.name.isEmpty)
                    }
                }
        }
    }
}

#Preview {
    AddTaskView(taskViewModel: TaskViewModel(), shouldAddTaskView: .constant(false), refreshTaskList: .constant(false))
}
