//
//  JournalEntryDetail.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

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
                HStack {
                    ForEach(0..<selectedJournalEntry.rating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                    ForEach(selectedJournalEntry.rating..<5, id: \.self) { _ in
                        Image(systemName: "star")
                            .foregroundColor(.yellow)
                    }
                }
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
