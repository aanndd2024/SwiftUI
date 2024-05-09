//
//  Date+Extension.swift
//  MyTask
//
//  Created by Anand Yadav on 08-05-2024.
//

import Foundation

extension Date {
    func toString() -> String {
        let formetter = DateFormatter()
        formetter.dateStyle = .short
        formetter.timeStyle = .short
        let result = formetter.string(from: self)
        return result
    }
}
