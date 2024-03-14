//
//  OnBoardingCell.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 13.03.2024.
//

import UIKit

class OnBoardingCell: UICollectionViewCell {
    
    static let identifier = "OnBoardingCell"
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFit
       imageView.clipsToBounds = true
       imageView.image = .o
       imageView.layer.cornerRadius = 16
       imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
   }()
   
    let titleLabel: UILabel = {
       let label = UILabel()
       label.textAlignment = .center
       label.numberOfLines = 3
       label.font = .systemFont(ofSize: 20, weight: .bold)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
   
   let descLabel: UILabel = {
      let label = UILabel()
      label.textAlignment = .center
      label.numberOfLines = 3
      label.textColor = .darkGray
      label.font = .systemFont(ofSize: 13, weight: .medium)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
  }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
        setupCons()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(descLabel)
      
    }
}

//MARK: - Configure Constrain
extension OnBoardingCell {
    
    func setupCons() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 100),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 50),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -50),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 15),
            descLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
}
