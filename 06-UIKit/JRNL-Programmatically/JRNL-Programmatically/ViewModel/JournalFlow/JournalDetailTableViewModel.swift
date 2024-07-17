//
//  JournalDetailTableViewModel.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import UIKit

final class JournalDetailTableViewModel {
    private let journal: Journal
    private(set) var fields: [any CommonField] = []
    
    init(journal: Journal) {
        self.journal = journal
        
        let dateField = CellField<JournalDetailTableLabelCell>(
            cellContentType: .label(
                journal.date.formatted(.dateTime.year().month().day()),
                .right
            )
        )
        let titleField = CellField<JournalDetailTableLabelCell>(
            cellContentType: .label(
                journal.journalTitle,
                .left
            )
        )
        let textField = CellField<JournalDetailTableTextCell>(
            cellContentType: .text(journal.journalDescription),
            height: 150
        )
        let imageField = CellField<JournalDetailTableImageCell>(
            cellContentType: .image(journal.photoUrl ?? ""),
            height: 316
        )
        
        self.fields = [
            dateField,
            titleField,
            textField,
            imageField
        ]
    }
}
