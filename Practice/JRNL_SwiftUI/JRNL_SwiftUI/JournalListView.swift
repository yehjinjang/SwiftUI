//
//  JournalListView.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

import SwiftUI
import SwiftData

struct JournalListView: View {
    @State private var isShowwAddJournal =  false
    @Query(sort:\JournalEntry.date) var journalEntries : [ JournalEntry]
    
    var body : some View {
        NavigationStack {
            List(journalEntries) { journalEntry in
                Text(journalEntry.entryTitle)
        
                
                
            }
            .navigationTitle("Journal List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button( "Add", systemImage: "plus"){
                        print("add")
                        
                    }
                }
                
            }
            .sheet(isPresented: $isShowwAddJournal) {
                AddJournalEntryView()
                
            }
                   }
    }
}


#Preview {
    JournalListView()
        .modelContainer(for: JournalEntry.self, inMemory: true)

}
