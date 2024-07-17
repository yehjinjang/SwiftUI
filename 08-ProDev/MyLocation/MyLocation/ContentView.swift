//
//  ContentView.swift
//  MyLocation
//
//  Created by Jungman Bae on 7/4/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var viewModel = MapViewModel()
    
    @State var style = 0
    
    let styles = ["standard", "imagery", "hybrid"]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Map(position: $viewModel.cameraPosition, selection: $viewModel.selectedPlace) {
                    ForEach(viewModel.searchResults, id: \.self) { place in
                        Annotation(place.name ?? "Unknown", coordinate: place.placemark.coordinate) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    }
                    if let route = viewModel.route {
                        MapPolyline(route.polyline)
                            .stroke(.blue, lineWidth: 5)
                    }
                }
                .mapStyle(viewModel.mapStyle)
                .onMapCameraChange { context in
                    let centerCoordinate = context.camera.centerCoordinate
                    viewModel.mapCenter = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
                }
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if viewModel.selectedPlace != nil {
                        PlaceInfoPanel(viewModel: viewModel)
                    }

                    HStack {
                        Button(action: {
                            viewModel.moveToCurrentLocation()
                        }) {
                            Image(systemName: "location.fill")
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        Spacer()
                    }
                }
                .padding()
            }
            .navigationTitle("MyLocation")
            .searchable(text: $viewModel.searchText, prompt: "Search for a place")
            .searchScopes($style) {
                Text("Standard").tag(0)
                Text("Imagery").tag(1)
                Text("Hybrid").tag(2)
            }
            .onChange(of: style) {
                switch style {
                case 0:
                    viewModel.mapStyle = .standard
                case 1:
                    viewModel.mapStyle = .imagery
                case 2:
                    viewModel.mapStyle = .hybrid
                default:
                    viewModel.mapStyle = .standard
                }
            }
            .onSubmit(of: .search) {
                viewModel.searchLocation()
            }
        }
    }
}

#Preview {
    ContentView()
}
