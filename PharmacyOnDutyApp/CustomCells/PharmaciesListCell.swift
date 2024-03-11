//
//  PharmaciesListCell.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 9.03.2024.
//

import UIKit

protocol PharmaciesListCellDelegate {
    func mapButtonClicked(latitude: Double, longitude: Double)
    func directionsButtonClicked(latitude: Double, longitude: Double, title: String)
}

class PharmaciesListCell: UICollectionViewCell {
    
    static let identifier = "PharmaciesListCell"
    var longitude = 0.0
    var latitude = 0.0
    var pharmaciesListCellDelegate: PharmaciesListCellDelegate?
   
   
    
    private let pharmacyTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pharmacyAdress: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pharmacyPhoneNumber: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let callButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ara", for: .normal)
        button.setImage(.phoneRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.borderWidth = 0.5
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let mapButton: UIButton = {
        let button = UIButton()
        button.setTitle("Haritada Göster", for: .normal)
        button.setImage(.mapRed, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.red.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        return button
    }()
    
    private let directionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Yol Tarifi", for: .normal)
        button.setImage(.directionsRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.borderWidth = 0.5
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let mapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .map
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .phone
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
       
        super .init(frame: frame)
        setupUI()
        setupCons()
        addButtonTargets()
        self.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addButtonTargets() {
        callButton.addTarget(self, action: #selector(clickedCallButton), for: .touchUpInside)
        mapButton.addTarget(self, action: #selector(clickedMapButton), for: .touchUpInside)
        directionsButton.addTarget(self, action: #selector(clickeDirectionsButton), for: .touchUpInside)
    }
    
    @objc func clickedCallButton() {
        if let phoneNumber = pharmacyPhoneNumber.text {
            if let phoneUrl = URL(string: "tel://\(phoneNumber)") {
                print(phoneUrl)
                if UIApplication.shared.canOpenURL(phoneUrl) {
                    UIApplication.shared.open(phoneUrl)
                } else {
                    print("ARAMA BUTONUNA BASTIN AMA ARAMA YAPMADI")
                }
            }
        }
    }

    @objc func clickedMapButton() {
        pharmaciesListCellDelegate?.mapButtonClicked(latitude: latitude, longitude: longitude)
    }
    
    @objc func clickeDirectionsButton() {
        pharmaciesListCellDelegate?.directionsButtonClicked(latitude: latitude, longitude: longitude, title: pharmacyTitle.text ?? "")
    }
    
    
    func setupUI() {
        self.addSubview(pharmacyTitle)
        self.addSubview(pharmacyAdress)
        self.addSubview(pharmacyPhoneNumber)
        self.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(callButton)
        buttonStackView.addArrangedSubview(mapButton)
        buttonStackView.addArrangedSubview(directionsButton)
        self.addSubview(mapImageView)
        self.addSubview(phoneImageView)
    }
    
    func setupRadius() {
        callButton.layer.cornerRadius = callButton.frame.height / 2
        callButton.layer.masksToBounds = true
        
        mapButton.layer.cornerRadius = mapButton.frame.height / 2
        mapButton.layer.masksToBounds = true
        
        directionsButton.layer.cornerRadius = directionsButton.frame.height / 2
        directionsButton.layer.masksToBounds = true
        
        self.layer.cornerRadius = 16
    }
    
    func configure(data: Cites) {
        pharmacyTitle.text = data.pharmacyName
        pharmacyAdress.text = data.address
        pharmacyPhoneNumber.text = data.phone
    }
    
    func configureLatitudeAndLongitude(data: Cites,latitude: Double?, longitude: Double?) {
        self.longitude = data.longitude ?? 0.0
        self.latitude = data.latitude ?? 0.0
    }
    
}

//MARK: - Configure ConstrainsUI

extension PharmaciesListCell {
    
    func setupCons() {
        pharmacyTitleCons()
        mapImageViewCons()
        pharmacyAdressCons()
        phoneImageViewCons()
        pharmacyPhoneNumberCons()
        buttonStackViewConstraints()
    }
    
    func pharmacyTitleCons() {
        NSLayoutConstraint.activate([
            pharmacyTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            pharmacyTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pharmacyTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            pharmacyTitle.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
 
    func mapImageViewCons() {
        NSLayoutConstraint.activate([
            mapImageView.topAnchor.constraint(equalTo: pharmacyTitle.bottomAnchor,constant: 10),
            mapImageView.heightAnchor.constraint(equalToConstant: 24),
            mapImageView.widthAnchor.constraint(equalToConstant: 24),
            mapImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
    }
 
    func pharmacyAdressCons() {
        NSLayoutConstraint.activate([
            pharmacyAdress.topAnchor.constraint(equalTo: mapImageView.topAnchor),
            pharmacyAdress.leadingAnchor.constraint(equalTo: mapImageView.trailingAnchor, constant: 5),
            pharmacyAdress.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            pharmacyAdress.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func phoneImageViewCons() {
        NSLayoutConstraint.activate([
            phoneImageView.topAnchor.constraint(equalTo: mapImageView.bottomAnchor,constant: 10),
            phoneImageView.leadingAnchor.constraint(equalTo: mapImageView.leadingAnchor),
            phoneImageView.widthAnchor.constraint(equalToConstant: 24),
            phoneImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
    }
    
    func pharmacyPhoneNumberCons() {
        NSLayoutConstraint.activate([
            pharmacyPhoneNumber.topAnchor.constraint(equalTo: phoneImageView.topAnchor, constant: 10),
            pharmacyPhoneNumber.leadingAnchor.constraint(equalTo: phoneImageView.trailingAnchor, constant: 5),
            pharmacyPhoneNumber.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    
    
    func buttonStackViewConstraints() {
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            buttonStackView.widthAnchor.constraint(equalTo:safeAreaLayoutGuide.widthAnchor,constant: -10),
            buttonStackView.heightAnchor.constraint(equalToConstant: 30),
            buttonStackView.topAnchor.constraint(equalTo: pharmacyPhoneNumber.bottomAnchor, constant: 10)
        ])
    }
    
 
}
