//
//  File.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

import Foundation
import UIKit

struct JournalEntry: Identifiable , Hashable {
    var id = UUID()
    var date: Date
    var entryTitle: String
    var entryBody: String
    var photo: UIImage?
    var latitude: Double?
    var longitude: Double?
}

let testData = [
    JournalEntry(date: Date(), entryTitle: "Sample Entry 1", entryBody: "This is a sample entry body.", photo: nil, latitude: 37.7749, longitude: -122.4194),
    JournalEntry(date: Date(), entryTitle: "Sample Entry 2", entryBody: "This is another sample entry body.", photo: nil, latitude: 34.0522, longitude: -118.2437)
]
