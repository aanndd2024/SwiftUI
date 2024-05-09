//
//  HomeView.swift
//  MyTask
//
//  Created by Anand Yadav on 07-05-2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var taskViewModel = TaskViewModel()
    @State private var picketFilter:[String] = ["Active", "Completed"]
    @State private var defaultPickerSelection:String = "Active"
    @State private var showAddTaskView:Bool = false
    @State private var showTaskDetailsView:Bool = false
    @State private var selectedTask:Task = Task(id: 0, name: "", desc: "", isCompleted: false, finishedDate: Date())
    @State private var refreshTaskList:Bool = false


    var body: some View {
        NavigationStack {
            Picker("Picker Filter", selection: $defaultPickerSelection) {
                ForEach(picketFilter, id:\.self) {options in
                    Text(options)
                }
            }.pickerStyle(.segmented)
                .onChange(of: defaultPickerSelection) { oldValue, newValue in
                    taskViewModel.getTask(isCompleted: defaultPickerSelection == "Active")
                }
            
            List(taskViewModel.task, id: \.id) { task in
                VStack(alignment: .leading) {
                    Text(task.name).font(.title)
                    HStack {
                        Text(task.desc).font(.subheadline).lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Text(task.finishedDate.toString())
                    }.onTapGesture {
                        selectedTask = task
                        showTaskDetailsView.toggle()
                    }
                }
            }.onAppear {
                taskViewModel.getTask(isCompleted: true)
            }.onChange(of: refreshTaskList, { oldValue, newValue in
                taskViewModel.getTask(isCompleted: defaultPickerSelection == "Active")
            })
            .listStyle(.plain).navigationTitle("Home")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddTaskView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showAddTaskView) {
                    AddTaskView(taskViewModel: taskViewModel, shouldAddTaskView: $showAddTaskView, refreshTaskList: $refreshTaskList)
                }
                .sheet(isPresented: $showTaskDetailsView) {
                    TaskDetailsView(taskViewModel: taskViewModel, showTaskDetailsView: $showTaskDetailsView, selectedTask: $selectedTask, refreshTaskList: $refreshTaskList)
                }
        }
    }
}

#Preview {
    HomeView()
}
 
