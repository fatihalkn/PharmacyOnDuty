//
//  HomeControllerCell.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 7.03.2024.
//

import UIKit

class HomeControllerCell: UICollectionViewCell {
   static let identifier = "HomeControllerCell"
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.backgroundColor = .white
        setupUI()
        setupCons()
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(cityLabel)
    }
    
    func setupRadius() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        
    }
    
    func configure(data: Datum) {
        cityLabel.text = data.cities
    }
    
}

//MARK: - Configure UI Constrain
extension HomeControllerCell {
    func setupCons() {
        cityLabelCons()
        
    }
    
    func cityLabelCons() {
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            cityLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: -20)
        ])
        
        
    }
}


