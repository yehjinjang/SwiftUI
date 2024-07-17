//
//  JournalEntryDetail.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//
//

import SwiftUI
import MapKit

struct JournalEntryDetailView: View {
    var journalEntry: JournalEntry
    @State private var mapImage: UIImage?
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer().frame(height: 30)
                RatingView(rating: .constant(journalEntry.rating))
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer().frame(height: 30)
                Text(journalEntry.date.formatted(.dateTime.year().month().day()))
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Spacer().frame(height: 30)
                Text(journalEntry.entryTitle)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 30)
                Text(journalEntry.entryBody)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 30)
                Image(uiImage: journalEntry.photo ?? UIImage(systemName: "face.smiling")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipped()
                Spacer().frame(height: 30)
                Image(uiImage: mapImage ?? UIImage(systemName: "map")!)
                    .resizable()
                    .frame(width: 300, height: 300)
            }
            .padding()
        }
        .navigationTitle("Entry Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            getMapSnapshot()
        }
    }
    
    private func getMapSnapshot() {
        if let lat = journalEntry.latitude,
           let long = journalEntry.longitude {
            let options = MKMapSnapshotter.Options()
            options.region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: lat, longitude: long),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            options.size = CGSize(width: 300, height: 300)
            options.preferredConfiguration = MKStandardMapConfiguration()
            
            let snapShotter = MKMapSnapshotter(options: options)
            snapShotter.start { snapshot, error in
                if let snap = snapshot {
                    mapImage = snap.image
                } else if let error = error {
                    print("error: \(error.localizedDescription)")
                }
            }
        } else {
            mapImage = UIImage(systemName: "map")
        }
    }
}
//import SwiftUI
//
//
//struct JournalEntryDetail: View {
//    var selectedJournalEntry: JournalEntry
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading) {
//                Text(selectedJournalEntry.date, style: .date)
//                    .font(.title)
//                    .fontWeight(.bold)
//                Text(selectedJournalEntry.entryTitle)
//                    .font(.title)
//                    .fontWeight(.bold)
//                Text(selectedJournalEntry.entryBody)
//                    .font(.title2)
//                HStack {
//                    ForEach(0..<selectedJournalEntry.rating, id: \.self) { _ in
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.yellow)
//                    }
//                    ForEach(selectedJournalEntry.rating..<5, id: \.self) { _ in
//                        Image(systemName: "star")
//                            .foregroundColor(.yellow)
//                    }
//                }
//                Image(uiImage: selectedJournalEntry.photo ?? UIImage(systemName: "face.smiling")!)
//                    .resizable()
//                    .frame(width: 300, height: 300)
//                MapView(journalEntry: selectedJournalEntry)
//                    .frame(height: 300)
//            }
//            .padding()
//            .navigationTitle("Entry Detail")
//        }
//    }
//}
