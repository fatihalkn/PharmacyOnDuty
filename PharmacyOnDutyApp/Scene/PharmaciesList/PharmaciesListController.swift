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
import GoogleMobileAds



class PharmaciesListController: UIViewController, GADBannerViewDelegate {
    
    let pharmaciesListViewModel = PharmaciesListModel()
    var city: String?
    var district: String?
    
    var bannerView: GADBannerView!
    
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
        bannerConfigure()
        view.backgroundColor = .bg
    }
    
    
    
    func bannerConfigure() {
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
        let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerView = GADBannerView(adSize: adaptiveSize)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2435281174"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        pharmaciesCollectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: adaptiveSize.size.height + 10, right: 20)
    }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      addBannerViewToView(bannerView)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: view.safeAreaLayoutGuide,
                              attribute: .bottom,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
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
    
    
    func mapButtonClicked(latitude: Double, longitude: Double, title: String) {
        let vc = MapController()
        vc.latitude = latitude
        vc.longitude = longitude
        vc.pharmacyTitle = title
        navigationController?.pushViewController(vc, animated: true)
       
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
        let cellWitdh: CGFloat = pharmaciesCollectionView.frame.width - 40
        let data = pharmaciesListViewModel.pharmacies[indexPath.item]
        let titleHeight = heightForLabel(text: data.pharmacyName ?? "", width: cellWitdh - 40, font: .systemFont(ofSize: 20, weight: .bold))
        var adressHeight = heightForLabel(text: data.address ?? "" , width: cellWitdh - (20 + 24 + 5 + 10), font: .systemFont(ofSize: 15, weight: .medium))
        if adressHeight < 24 {
            adressHeight = 24
        }
        var phoneHeight = heightForLabel(text: data.phone ?? "" , width: cellWitdh - (24 + 5 + 10), font: .systemFont(ofSize: 15, weight: .medium))
        if phoneHeight < 24 {
            phoneHeight = 24
        }
        
        let totalHeight = titleHeight + adressHeight + phoneHeight + (10 + 10 + 10 + 10 + 20 + 30)
        
        return .init(width: cellWitdh, height: totalHeight)
    }
    
    func heightForLabel(text: String, width: CGFloat, font: UIFont) -> CGFloat {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.font = font
            label.text = text
            label.sizeToFit()
            return label.frame.height
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
