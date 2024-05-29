//
//  ContentView.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            JournalListView()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
