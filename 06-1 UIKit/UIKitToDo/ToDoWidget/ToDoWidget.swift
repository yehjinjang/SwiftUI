//
//  ToDoWidget.swift
//  ToDoWidget
//
//  Created by 장예진 on 5/24/24.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), todos: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), todos: loadTodos())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, todos: loadTodos())
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    // UserDefaults에서 할 일 목록을 로드하는 함수
    func loadTodos() -> [ToDo] {
        if let data = UserDefaults(suiteName: "group.com.yourappname.widget")?.data(forKey: "todos"),
           let savedTodos = try? JSONDecoder().decode([ToDo].self, from: data) {
            return savedTodos
        }
        return []
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let todos: [ToDo]
}

struct WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            Text("To-Do List").font(.headline)
            ForEach(entry.todos.prefix(3)) { todo in
                Text(todo.title)
                    .font(.subheadline)
                    .padding(.bottom, 2)
            }
            Spacer()
        }
        .padding()
    }
}

@main
struct ToDoWidget: Widget {
    let kind: String = "ToDoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("To-Do List")
        .description("View your upcoming tasks.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
