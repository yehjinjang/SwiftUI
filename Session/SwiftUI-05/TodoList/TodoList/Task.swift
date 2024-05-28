//
//  Item.swift
//  TodoList
//
//  Created by Jungman Bae on 4/25/24.
//

import Foundation
import SwiftData

enum Priority: Comparable, Codable {
    case high
    case medium
    case low
}

@Model
final class Task {
    var id = UUID()
    var completed: Bool = false
    var text: String
    var priority: Priority
    
    init(text: String, priority: Priority) {
        self.text = text
        self.priority = priority
    }
}

extension Task {
    static var tasks = [
        Task(text: "Wake up", priority: .low),
        Task(text: "Shower", priority: .medium),
        Task(text: "Code", priority: .high),
        Task(text: "Eat", priority: .high),
        Task(text: "Sleep", priority: .high),
        Task(text: "Get groceries", priority: .high)
    ]
    static var task = tasks[0]
}
