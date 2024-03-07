//
//  HomeController.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 7.03.2024.
//

import Foundation
import UIKit

class HomeController : UIViewController {

    var cities: [Cites] = []
    
    private let homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .bg
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        return collectionView
        
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        let imageIcon = UIImageView()
        imageIcon.image = .search
        imageIcon.tintColor = .black
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 5, y: 0, width: (UIImage(named: "search")?.size.width)!, height: (UIImage(named: "search")?.size.height)!)
        imageIcon.frame = CGRect(x: 5, y: 0, width: (UIImage(named: "search")?.size.width)!, height: (UIImage(named: "search")?.size.height)!)
        textField.leftView = contentView
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Search..."
        textField.backgroundColor = .white
        textField.font = .systemFont(ofSize: 15, weight: .light)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
    }()
    
    private let homePageTitle: UILabel = {
        let label = UILabel()
        label.text = "Lütfen İl/ilçe seçimi yapınız"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegate()
        setupRegister()
        setupCons()
        getData()
        isSucceed()
        let appearanca = UINavigationBarAppearance()
        appearanca.configureWithOpaqueBackground()
        navigationItem.standardAppearance = appearanca
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRadius()
        
    }
    
    func setupUI() {
        view.addSubview(homePageTitle)
        view.addSubview(searchTextField)
        view.addSubview(homeCollectionView)
        view.backgroundColor = .bg
        navigationItem.title = "Nöbetçi Eczaneler"
    
        
    }
    
    func setupRadius() {
        searchTextField.layer.cornerRadius = searchTextField.frame.height / 2
        searchTextField.layer.masksToBounds = true
    }
    
    func setupDelegate() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
    }
    
    func setupRegister() {
        homeCollectionView.register(HomeControllerCell.self, forCellWithReuseIdentifier: HomeControllerCell.identifier)
        
    }
    
    func getData() {
        viewModel.getAllCity()
    }
    
    func isSucceed() {
        viewModel.successCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.homeCollectionView.reloadData()
            }
        }
    }
}

//MARK: - Configure CollectionView
extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeControllerCell.identifier, for: indexPath) as! HomeControllerCell
        let data = viewModel.cities[indexPath.item]
        cell.configure(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 40
        let cellHeight: CGFloat = 40
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

//MARK: - Configure UI Constrains
extension HomeController {
    
    func setupCons() {
        homeCollectionViewCons()
        homePageTitleCons()
        searchTextFiledCons()
    }
    
    func homePageTitleCons() {
        NSLayoutConstraint.activate([
            homePageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            homePageTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            homePageTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            homePageTitle.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func searchTextFiledCons() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: homePageTitle.bottomAnchor,constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            searchTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func homeCollectionViewCons() {
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

