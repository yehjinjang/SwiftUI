//
//  JournalMock.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import Foundation

extension Journal {
    static var mock: Self {
        Self.mocks[0]
    }
    
    static var mocks: [Self] {
        [
            .init(
                rating: 0,
                journalTitle: "Bad",
                journalDescription: "Today is bad day",
                photoUrl: "cloud"
            ),
            .init(
                rating: 5,
                journalTitle: "Good",
                journalDescription: "Today is good day",
                photoUrl: "sun.max"
            ),
            .init(
                rating: 3,
                journalTitle: "Ok",
                journalDescription: "Today is Ok day",
                photoUrl: "cloud.sun"
            )
        ]
    }
}
