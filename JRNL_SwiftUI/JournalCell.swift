//
//  JournalCell.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

import SwiftUI
import UIKit

struct JournalCell: View {
    var journalEntry: JournalEntry
    var body: some View {
        NavigationLink(value: journalEntry) {
            HStack {
                Image(uiImage: journalEntry.photo ?? UIImage(systemName: "face.smiling")!)
                    .resizable()
                    .frame(width: 90, height: 90)
                VStack(alignment: .leading) {
                    Text(journalEntry.date, style: .date)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(journalEntry.entryTitle)
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
        }
    }
}
