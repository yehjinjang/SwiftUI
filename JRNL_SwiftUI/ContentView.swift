//
//  ContentView.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

import SwiftUI

struct ContentView: View {
    var journalEntries: [JournalEntry] = testData
    var body: some View {
        NavigationStack {
            List(journalEntries) { journalEntry in
                JournalCell(journalEntry: journalEntry)
            }
            .navigationTitle("Journal List")
            .navigationDestination(for: JournalEntry.self) { journalEntry in
                JournalEntryDetail(selectedJournalEntry: journalEntry)
            }
        }
    }
}

#Preview {
    ContentView()
}
