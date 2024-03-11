//
//  PharmaciesListController.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 9.03.2024.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class PharmaciesListController: UIViewController {
    
    let pharmaciesListViewModel = PharmaciesListModel()
    var city: String?
    var district: String?
    
    private let pharmaciesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .bg
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegate()
        setupRegister()
        pharmaciesCollectionViewCons()
        getData()
        isSucceed()
        view.backgroundColor = .bg
    }
    
    func setupDelegate() {
        pharmaciesCollectionView.delegate = self
        pharmaciesCollectionView.dataSource = self
    }
    
    func setupRegister() {
        pharmaciesCollectionView.register(PharmaciesListCell.self, forCellWithReuseIdentifier: PharmaciesListCell.identifier)
        
    }
    
    func setupUI() {
        view.addSubview(pharmaciesCollectionView)
    }
    
    func getData() {
        guard let city else { return }
        guard let district else { return }
        pharmaciesListViewModel.getDistrictPharmacy(selectedCity: city, selectedDisctrict: district)
    }
    
    func isSucceed() {
        pharmaciesListViewModel.successCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.pharmaciesCollectionView.reloadData()
            }
        }
    }
    
}

//MARK: - Map ButtonProtocol
extension PharmaciesListController: PharmaciesListCellDelegate {
    func directionsButtonClicked(latitude: Double, longitude: Double, title: String) {
        let latitude: CLLocationDegrees = latitude
        print(latitude)
        let longitude: CLLocationDegrees = longitude
        print(longitude)
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                         MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        mapItem.openInMaps(launchOptions: options)
    }
    
    
    func mapButtonClicked(latitude: Double, longitude: Double) {
        let vc = MapController()
        vc.latitude = latitude
        vc.longitude = longitude
        navigationController?.pushViewController(vc, animated: true)
        print("mapButtonClicked = latitude: \(latitude) and longitude: \(longitude)")
    }
    
    
}

//MARK: - Configure CollectionView

extension PharmaciesListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return pharmaciesListViewModel.pharmacies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pharmaciesCollectionView.dequeueReusableCell(withReuseIdentifier: "PharmaciesListCell", for: indexPath) as! PharmaciesListCell
        let data = pharmaciesListViewModel.pharmacies[indexPath.item]
        cell.pharmaciesListCellDelegate = self
        cell.configure(data: data)
        cell.configureLatitudeAndLongitude(data: data, latitude: data.latitude, longitude: data.longitude)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWitdh: CGFloat = pharmaciesCollectionView.frame.width - 30
        let cellHeigt: CGFloat = pharmaciesCollectionView.frame.height / 3
        return .init(width: cellWitdh, height: cellHeigt)
    }
}

//MARK: -  Configure Constrain

extension PharmaciesListController {
    
    func pharmaciesCollectionViewCons() {
        NSLayoutConstraint.activate([
            pharmaciesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pharmaciesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pharmaciesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pharmaciesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
