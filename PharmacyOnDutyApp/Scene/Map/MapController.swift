//
//  MapController.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 10.03.2024.
//

import Foundation
import UIKit
import MapKit

class MapController: UIViewController, MKMapViewDelegate {
    let mapControllerViewModel = MapControllerViewModel()
    var latitude: Double?
    var longitude: Double?
    let locationManager = CLLocationManager()
    private var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        mapViewCons()
        mapView.delegate = self
        locationPermission()
        view.backgroundColor = .bg
        navigationItem.title = "Harita Görünümğ"
        getData(longitude: latitude, latitude: longitude)
    }
    
    func locationPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setupUI() {
        mapView = MKMapView()
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let location = CLLocationCoordinate2D(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
        print(location)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        mapView.setCenter(location, animated: true)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004))
        mapView.setRegion(region, animated: true)
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        view.addSubview(mapView)
    }

    
    func getData(longitude: Double?, latitude: Double?) {
        self.longitude = longitude
        self.latitude = latitude
        guard let longitude = longitude, let latitude = latitude else { return }
        mapControllerViewModel.getLatitudeAndLongitude(latitude: latitude, longitude: longitude)
    }
    
    
    func isSuceed() {
        mapControllerViewModel.successCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.mapView.reloadInputViews()
            }
        }
    }
 
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolygonRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 3.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {}
    }
 
//MARK: - Configure Constrains
extension MapController {
    
    func mapViewCons() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
}
