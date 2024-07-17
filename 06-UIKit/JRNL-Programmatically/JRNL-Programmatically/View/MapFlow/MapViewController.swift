//
//  MapViewController.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/9/24.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(mapView)
        
        view.backgroundColor = .white
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        let global = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: global.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: global.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: global.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: global.bottomAnchor),
        ])
    }
}
