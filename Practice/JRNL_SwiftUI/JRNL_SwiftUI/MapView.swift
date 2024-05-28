//
//  MapView.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    var journalEntry: JournalEntry

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [journalEntry]) { entry in
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: entry.latitude ?? 0.0, longitude: entry.longitude ?? 0.0), tint: .red)
        }
        .onAppear {
            setRegion(journalEntry)
        }
        .frame(height: 300)
    }

    private func setRegion(_ entry: JournalEntry) {
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: entry.latitude ?? 0.0, longitude: entry.longitude ?? 0.0),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
}
