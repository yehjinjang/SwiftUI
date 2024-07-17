//
//  ContentView.swift
//  EditableList
//
//  Created by Jungman Bae on 4/24/24.
//

import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
}

struct ContentView: View {
    
    @State private var todos = [
        TodoItem(title: "Eat"),
        TodoItem(title: "Sleep"),
        TodoItem(title: "Code"),
    ]
    
    var body: some View {
        List($todos) { todo in
            TextField("Todo Item", text: todo.title)
        }
        
//        List(0..<todos.count) { index in
//            TextField("Todo Item", text: $todos[index].title)
//        }
    }
}

#Preview {
    ContentView()
}
