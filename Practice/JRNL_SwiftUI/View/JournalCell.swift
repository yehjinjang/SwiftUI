//
//  JournalCell.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//


import SwiftUI

struct JournalCell: View {
    var journalEntry: JournalEntry
    
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: journalEntry.photo ?? UIImage(systemName: "face.smiling")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipped()
                VStack {
                    Text(journalEntry.date.formatted(.dateTime.year().month().day()))
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(journalEntry.entryTitle)
                        .font(.title2)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

//import SwiftUI
//import UIKit
//
//struct JournalCell: View {
//    var journalEntry: JournalEntry
//    
//    var body: some View {
//        HStack {
//            Image(uiImage: journalEntry.photo ?? UIImage(systemName: "face.smiling")!)
//                .resizable()
//                .frame(width: 90, height: 90)
//            VStack(alignment: .leading) {
//                Text(journalEntry.date, style: .date)
//                    .font(.title)
//                    .fontWeight(.bold)
//                Text(journalEntry.entryTitle)
//                    .font(.title2)
//                    .foregroundStyle(.secondary)
//                HStack {
//                    ForEach(0..<journalEntry.rating, id: \.self) { _ in
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.yellow)
//                    }
//                    ForEach(journalEntry.rating..<5, id: \.self) { _ in
//                        Image(systemName: "star")
//                            .foregroundColor(.yellow)
//                    }
//                }
//            }
//            .padding()
//        }
//    }
//}
