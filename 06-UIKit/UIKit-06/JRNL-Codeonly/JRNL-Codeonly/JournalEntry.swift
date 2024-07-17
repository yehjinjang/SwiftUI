//
//  JournalEntry.swift
//  JRNL
//
//  Created by Jungman Bae on 5/10/24.
//

//import UIKit
//
//
//class JournalEntry {
//    // MARK: - Properties
//    let date: Date
//    let rating: Int
//    let entryTitle: String
//    let entryBody: String
//    let photo: UIImage?
//    let latitude: Double?
//    let longitude: Double?
//    
//    // MARK: - Intialization
//    init?(rating: Int, title: String, body: String,
//          photo: UIImage? = nil, latitude: Double? = nil, longitude: Double? = nil) {
//        if title.isEmpty || body.isEmpty || rating < 0 || rating > 5 {
//            return nil
//        }
//        self.date = Date()
//        self.rating = rating
//        self.entryTitle = title
//        self.entryBody = body
//        self.photo = photo
//        self.latitude = latitude
//        self.longitude = longitude
//    }
//}

import UIKit
import MapKit

class JournalEntry: NSObject, MKAnnotation{
        let date: Date
        let rating: Int
        let entryTitle: String
        let entryBody: String
        let photo: UIImage?
        let latitude: Double?
        let longitude: Double?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
    }

    init?(rating: Int, title: String, body: String,
          photo: UIImage? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        if title.isEmpty || body.isEmpty || rating < 0 || rating > 5 {
            return nil
        }
        self.date = Date()
        self.rating = rating
        self.entryTitle = title
        self.entryBody = body
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
    }
}
// MARK: - Sample data
struct SampleJournalEntryData {
    var journalEntries: [JournalEntry] = []
    
    mutating func createSampleJournalEntryData() {
        let photo1 = UIImage(systemName: "sun.max")
        let photo2 = UIImage(systemName: "cloud")
        let photo3 = UIImage(systemName: "cloud.sun")
        guard let journalEntry1 = JournalEntry(rating: 5, title: "Good",
                                               body: "Today is good day", photo: photo1) else {
            fatalError("Unable to instantiate journalEntry1")
        }
        guard let journalEntry2 = JournalEntry(rating: 0, title: "Bad",
                                               body: "Today is bad day", photo: photo2) else {
            fatalError("Unable to instantiate journalEntry2")
        }
        guard let journalEntry3 = JournalEntry(rating: 3, title: "Ok",
                                               body: "Today is Ok day", photo: photo3) else {
            fatalError("Unable to instantiate journalEntry3")
        }
        
        journalEntries += [journalEntry1, journalEntry2, journalEntry3]
        
    }
}
