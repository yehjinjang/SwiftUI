//
//  Journal.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import Foundation

struct Journal: Identifiable {
    let id: UUID
    let date: Date
    let rating: Int
    let journalTitle: String
    let journalDescription: String
    let photoUrl: String?
    let latitude: Double?
    let longitude: Double?
    
    init(
        id: UUID = UUID(),
        date: Date = .now,
        rating: Int,
        journalTitle: String,
        journalDescription: String,
        photoUrl: String?,
        latitude: Double? = nil,
        longitude: Double? = nil
    ) {
        self.id = id
        self.date = date
        self.rating = rating
        self.journalTitle = journalTitle
        self.journalDescription = journalDescription
        self.photoUrl = photoUrl
        self.latitude = latitude
        self.longitude = longitude
    }
}
