//
//  MapView.swift
//  JRNL_SwiftUI
//
//  Created by 장예진 on 5/28/24.
//

import SwiftUI
import MapKit
import CoreLocation
import SwiftData

struct MapUIView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var annotations: [MKAnnotation]
    @Binding var selectedAnnotation: JournalMapAnnotation?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        uiView.addAnnotations(annotations)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapUIView
        
        init(_ parent: MapUIView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
            let identifier = "mapAnnotation"
            if annotation is JournalMapAnnotation {
                if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                    annotationView.annotation = annotation
                    return annotationView
                } else {
                    let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    annotationView.canShowCallout = true
                    let calloutButton = UIButton(type: .detailDisclosure)
                    annotationView.rightCalloutAccessoryView = calloutButton
                    return annotationView
                }
            }
            return nil
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if let journalAnnotation = view.annotation as? JournalMapAnnotation {
                print(journalAnnotation.journal.entryTitle)
                parent.selectedAnnotation = journalAnnotation
            }
        }
    
    }
}


struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var annotations: [MKAnnotation] = []
    @State private var isDetailViewActive = false
    @State private var selectedAnnotation: JournalMapAnnotation?
    
    @StateObject private var locationManager = LocationManager()
    @Query(sort: \JournalEntry.date) var journalEntries: [JournalEntry]
    
    var body: some View {
        NavigationStack {
            MapUIView(region: $region, annotations: $annotations,
                      selectedAnnotation: $selectedAnnotation)
                .onAppear {
                    locationManager.requestLocation()
                }
                .onReceive(locationManager.$location) { location in
                    if let location = location {
                        region = MKCoordinateRegion(center: location.coordinate,
                                                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                        annotations = journalEntries.map { JournalMapAnnotation(journal: $0) }
                    }
                }
                .navigationTitle("Map")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(isPresented: Binding(get: { selectedAnnotation != nil },
                                                            set: { if !$0 {selectedAnnotation = nil} })) {
                    if let journalEntry = selectedAnnotation?.journal {
                        JournalEntryDetailView(journalEntry: journalEntry)
                    }
                }
        }
    }
}

#Preview {
    MapView()
}

// import SwiftUI
// import MapKit
//
//struct MapView: View {
//    var journalEntry: JournalEntry
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//    )
//
//    var body: some View {
//        Map(coordinateRegion: $region, annotationItems: [journalEntry]) { entry in
//            MapMarker(coordinate: CLLocationCoordinate2D(latitude: entry.latitude ?? 0.0, longitude: entry.longitude ?? 0.0), tint: .red)
//        }
//        .onAppear {
//            setRegion(journalEntry)
//        }
//        .frame(height: 300)
//    }
//
//    private func setRegion(_ entry: JournalEntry) {
//        region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: entry.latitude ?? 0.0, longitude: entry.longitude ?? 0.0),
//            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        )
//    }
//}
