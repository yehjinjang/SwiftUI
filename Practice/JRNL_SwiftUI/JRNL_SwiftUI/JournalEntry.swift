//
//  File.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

import Foundation
import SwiftData

@Model
class JournalEntry {
    let date: Date
    let rating: Int
    let entryTitle: String
    let entryBody: String
    let latitude: Double?
    let longitude: Double?
    
    init(rating: Int, entryTitle: String, entryBody: String,
         latitude: Double?, longitude: Double?) {
        self.date = Date()
        self.rating = rating
        self.entryTitle = entryTitle
        self.entryBody = entryBody
        self.latitude = latitude
        self.longitude = longitude
    }
}

//struct JournalEntry: Identifiable , Hashable {
//    var id = UUID()
//    var date: Date
//    var entryTitle: String
//    var entryBody: String
//    var rating : Int
//    var photo: UIImage?
//    var latitude: Double?
//    var longitude: Double?
//}
//
//
//let testData = [
//    JournalEntry(date: Date(), entryTitle: "Sample Entry 1", entryBody: "This is a sample entry body.", rating: 4, photo: UIImage(systemName: "face.smiling"), latitude: 37.7749, longitude: -122.4194),
//    JournalEntry(date: Date(), entryTitle: "Sample Entry 2", entryBody: "This is another sample entry body.", rating: 5, photo: UIImage(systemName: "face.smiling"), latitude: 34.0522, longitude: -118.2437)
//]
