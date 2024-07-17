//
//  JournalListViewModel.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import Foundation

final class JournalListViewModel {
    private(set) var journals: [Journal] = Journal.mocks
    
    func appendJournal(_ journal: Journal) {
        journals.append(journal)
    }
}
