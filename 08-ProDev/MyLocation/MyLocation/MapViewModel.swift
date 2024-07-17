//
//  MapViewModel.swift
//  MyLocation
//
//  Created by Jungman Bae on 7/4/24.
//
import SwiftUI
import MapKit

@Observable
class MapViewModel: NSObject {
    var searchText = ""
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var mapCenter: CLLocation?
    var selectedPlace: MKMapItem?
    var route: MKRoute?
    var searchResults: [MKMapItem] = []
    var mapStyle: MapStyle = .standard
    
    private var locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getDirections(to destination: MKMapItem) {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = destination
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let response = response else { return }
            self?.route = response.routes.first
        }
    }
    
    func searchLocation() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.resultTypes = .pointOfInterest
        
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] response, error in
            guard let self = self, let response = response, let mapCenter = mapCenter else { return }
            self.searchResults = response.mapItems
            
            if let nearestPlace = searchResults.min(by: {
                mapCenter.distance(from: CLLocation(latitude: $0.placemark.coordinate.latitude, longitude: $0.placemark.coordinate.longitude)) <
                mapCenter.distance(from: CLLocation(latitude: $1.placemark.coordinate.latitude, longitude: $1.placemark.coordinate.longitude))
            }) {
                let nearestCoordinate = nearestPlace.placemark.coordinate
                
                // 두 지점 사이의 거리 계산
                let distance = mapCenter.distance(from: CLLocation(latitude: nearestCoordinate.latitude, longitude: nearestCoordinate.longitude))
                
                // 거리에 따라 지도 스케일 조정
                let region = regionThatFits(center: mapCenter.coordinate, nearestCoordinate: nearestCoordinate)
                
                // 애니메이션과 함께 카메라 위치 업데이트
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.cameraPosition = .region(region)
                }
            }
        }
    }
    
    func regionThatFits(center: CLLocationCoordinate2D, nearestCoordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        let centerLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
        let nearestLocation = CLLocation(latitude: nearestCoordinate.latitude, longitude: nearestCoordinate.longitude)
        
        let distance = centerLocation.distance(from: nearestLocation)
        let maxDistance = max(distance, 1000) // 최소 1km
        
        // 대각선 거리의 1.5배를 사용하여 두 지점이 충분히 들어가도록 합니다
        let regionDistance = maxDistance * 1.5
        
        let midpoint = CLLocationCoordinate2D(
            latitude: (center.latitude + nearestCoordinate.latitude) / 2,
            longitude: (center.longitude + nearestCoordinate.longitude) / 2
        )
        
        return MKCoordinateRegion(
            center: midpoint,
            latitudinalMeters: regionDistance,
            longitudinalMeters: regionDistance
        )
    }


    func moveToCurrentLocation() {
        cameraPosition = .userLocation(fallback: .automatic)
    }
    
    func shareLocation() {
        guard let selectedPlace = selectedPlace else { return }
        let coordinate = selectedPlace.placemark.coordinate
        let placeName = selectedPlace.name ?? "선택된 위치"
        
        // CLGeocoder를 사용하여 주소 변환
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard self != nil else { return }
            
            var address = "주소를 찾을 수 없습니다."
            if let placemark = placemarks?.first {
                address = [
                    placemark.name,
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.country
                ]
                    .compactMap { $0 }
                    .joined(separator: ", ")
            }
            
            // 지도 링크 생성
            let mapLink = "http://maps.apple.com/?ll=\(coordinate.latitude),\(coordinate.longitude)"
            
            // 공유 텍스트 생성
            let shareText = "\(placeName) - 위도: \(coordinate.latitude), 경도: \(coordinate.longitude)\n\(address)\n지도 링크: \(mapLink)"
            
            
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
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        cameraPosition = .region(MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("error: \(error.localizedDescription)")
    }
}
