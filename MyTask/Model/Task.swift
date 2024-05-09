//
//  Task.swift
//  MyTask
//
//  Created by Anand Yadav on 06-05-2024.
//

import Foundation

struct Task {
    let id:Int
    var name:String
    var desc:String
    var isCompleted:Bool
    var finishedDate:Date
    
    static func createMockTask() -> [Task] {
        return [
            Task(id: 1, name: "Walk", desc: "Morning Walk", isCompleted: true, finishedDate: Date()),
            Task(id: 2, name: "Swiming", desc: "Evening Gym", isCompleted: true, finishedDate: Date()),
            Task(id: 3, name: "Swiming", desc: "Evening Gym", isCompleted: false, finishedDate: Date())
        ]
    }
}
