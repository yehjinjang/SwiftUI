//
//  MapViewModel.swift
//  SearchLocationApp
//
//  Created by Jungman Bae on 7/4/24.
//

import SwiftUI
import MapKit

@Observable
class MapViewModel: NSObject, CLLocationManagerDelegate {
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var searchText = ""
    var mapStyle: MapStyle = .standard
    var searchResults: [MKMapItem] = []
    var selectedPlace: MKMapItem?
    var route: MKRoute?
    
    private var locationManager: CLLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func moveToCurrentLocation() {
        cameraPosition = .userLocation(fallback: .automatic)
    }
    
    func searchLocation() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.resultTypes = .pointOfInterest
        
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] response, error in
            guard let response = response else { return }
            self?.searchResults = response.mapItems
        }
    }
    
    func getDirection() {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = selectedPlace!
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let response = response else { return }
            self?.route = response.routes.first
        }
    }
    
    func shareLocation() {
        guard let selectedPlace = selectedPlace else { return }
        let coordinate = selectedPlace.placemark.coordinate
        let placeName = selectedPlace.name ?? "선택된 위치"
                
        // 지도 링크 생성
        let mapLink = "http://maps.apple.com/?ll=\(coordinate.latitude),\(coordinate.longitude)"
        
        // 공유 텍스트 생성
        let shareText = "\(placeName) - 지도 링크: \(mapLink)"
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            
            if let popoverPresentationController = activityViewController.popoverPresentationController {
                popoverPresentationController.sourceView = rootViewController.view
                popoverPresentationController.sourceRect = CGRect(x: rootViewController.view.bounds.midX, y: rootViewController.view.bounds.midY, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
            }

            rootViewController.present(activityViewController, animated: true, completion: nil)
        }


    }
    
    // MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("error \(error.localizedDescription)")
    }
}
