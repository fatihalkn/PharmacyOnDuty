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
    var pharmacyTitle: String?
    let locationManager = CLLocationManager()

    private var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        mapViewCons()
        mapView.delegate = self
        locationPermission()
        view.backgroundColor = .bg
        navigationItem.title = "Harita Görünümü"
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
        let annotation = MKPointAnnotation()
        annotation.title = ""
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
               return nil
           }
        let identifier = "CustomPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }

            
            let pinImage = UIImage(named: "pharmacyPinRed")
            annotationView?.image = pinImage

            return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let alertController = UIAlertController(title: "Yol Tarifi Gösterilmesini İster Misiniz ?", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Konuma Git", style: .default) { action in
            let latitude: CLLocationDegrees = self.latitude ?? 0.0
            let longitude: CLLocationDegrees = self.longitude ?? 0.0
            
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(longitude, latitude)
            print(coordinates)
            
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                             MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
            
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = self.pharmacyTitle
            mapItem.openInMaps(launchOptions: options)
        }
        let cancelAction = UIAlertAction(title: "Çık", style: .default, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
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
