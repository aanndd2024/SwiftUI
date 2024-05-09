//
//  TaskViewModel.swift
//  MyTask
//
//  Created by Anand Yadav on 06-05-2024.
//

import Foundation

class TaskViewModel: ObservableObject {
    
    @Published var task: [Task] = []
    private var mockTasks = Task.createMockTask()
    
    func getTask(isCompleted:Bool) {
        task = mockTasks.filter({$0.isCompleted == !isCompleted})
    }
    
    func addTask(task:Task) -> Bool {
        let taskId = Int.random(in: 4...200)
        let taskToAdd = Task(id: taskId, name: task.name, desc: task.desc, isCompleted: task.isCompleted, finishedDate: task.finishedDate)
        mockTasks.append(taskToAdd)
        return true
    }
    
    func updateTask(task:Task) -> Bool {
        if let index = mockTasks.firstIndex(where: {$0.id == task.id}) {
            mockTasks[index].name = task.name
            mockTasks[index].desc = task.desc
            mockTasks[index].finishedDate = task.finishedDate
            mockTasks[index].isCompleted = task.isCompleted
            return true
        }
        return false
    }
    
    func deleteTask(task:Task) -> Bool {
        if let index = mockTasks.firstIndex(where: {$0.id == task.id}) {
            mockTasks.remove(at: index)
            return true
        }
        return false
    }

}
