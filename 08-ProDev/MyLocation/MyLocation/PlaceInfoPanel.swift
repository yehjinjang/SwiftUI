//
//  PlaceInfoPanel.swift
//  MyLocation
//
//  Created by Jungman Bae on 7/4/24.
//

import SwiftUI

struct PlaceInfoPanel: View {
    var viewModel: MapViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.selectedPlace?.name ?? "Unknown Place")
                .font(.headline)
            Text(viewModel.selectedPlace?.placemark.title ?? "")
                .font(.subheadline)
            HStack {
                if let place = viewModel.selectedPlace {
                    Button(action: {
                        viewModel.getDirections(to: place)
                    }) {
                        Label("경로", systemImage: "map")
                    }
                    
                    Spacer()
                }
                Button(action: {
                    viewModel.shareLocation()
                }) {
                    Label("공유", systemImage: "square.and.arrow.up")
                }
                .padding(.top)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    PlaceInfoPanel(viewModel: MapViewModel())
}
