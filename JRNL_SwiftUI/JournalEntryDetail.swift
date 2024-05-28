//
//  JournalEntryDetail.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

import SwiftUI

import SwiftUI

struct JournalEntryDetail: View {
    var selectedJournalEntry: JournalEntry

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(selectedJournalEntry.date, style: .date)
                    .font(.title)
                    .fontWeight(.bold)
                Text(selectedJournalEntry.entryTitle)
                    .font(.title)
                    .fontWeight(.bold)
                Text(selectedJournalEntry.entryBody)
                    .font(.title2)
                Image(uiImage: selectedJournalEntry.photo ?? UIImage(systemName: "face.smiling")!)
                    .resizable()
                    .frame(width: 300, height: 300)
                MapView(journalEntry: selectedJournalEntry)
                    .frame(height: 300)
            }
            .padding()
            .navigationTitle("Entry Detail")
        }
    }
}
