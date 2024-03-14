//
//  OnBoardingController.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 13.03.2024.
//

import Foundation
import UIKit

class OnBoardingController: UIViewController {
    
    let data: [OnBoardingModel] = [.init(imageName: "o", title: "Hoş Geldiniz!", descTitle: " Sağlık ihtiyaçlarınızı karşılamak için en yakın nöbetçi eczanelere kolayca erişin."),
                                   .init(imageName: "o2", title: "Kolay Kullanım", descTitle: "Kullanıcı dostu tasarımımızla, ilaç arama ve eczane bulma işlemleri artık daha kolay ve hızlı."),
                                   .init(imageName: "o3", title: "Konum Tabanlı Arama", descTitle: "Sadece birkaç dokunuşla, bulunduğunuz konuma en yakın nöbetçi eczaneleri bulun.")]
    
    
    private var currentPage = 0 {
        didSet {
            updateContinueButtonTitle()
        }
    }
    
    private let onBoardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let pageController: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .bg
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private let contiuneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Devam", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .bg
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCons()
        setupDelegate()
        setupRegister()
        addTargetButton()
        pageController.numberOfPages = data.count
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRadius()
    }
    
    func setupDelegate() {
        onBoardingCollectionView.delegate = self
        onBoardingCollectionView.dataSource = self
    }
    
    func setupRegister() {
        onBoardingCollectionView.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.identifier)
    }
    
    func setupUI() {
        view.addSubview(onBoardingCollectionView)
        view.addSubview(pageController)
        view.addSubview(contiuneButton)
        view.backgroundColor = .white
    }
    
    func setupRadius() {
        contiuneButton.layer.cornerRadius = contiuneButton.frame.height / 2
        contiuneButton.layer.masksToBounds = true
    }
    
    func updateContinueButtonTitle() {
        if currentPage == data.count - 1 {
            contiuneButton.setTitle("Başla", for: .normal)
        } else {
            contiuneButton.setTitle("Devam", for: .normal)
        }
    }
    
    func handleOnboardingCompletion() {
        let vc = HomeController()
        navigationController?.pushViewController(vc, animated: true)
        isOnboardingComlated(value: true)
        
       
    }
    
    func isOnboardingComlated(value: Bool) {
        UserDefaults.standard.set(value, forKey: "isOnboardingComlated")
        UserDefaults.standard.synchronize()
        print("isFirstTimeUser set to \(value)")
    }
    
    func addTargetButton() {
        contiuneButton.addTarget(self, action: #selector(contiuneButtonClicked), for: .touchUpInside)
    }
    
    @objc func contiuneButtonClicked() {
        if currentPage < data.count - 1 {
            currentPage += 1
            let indexPathToScroll = IndexPath(item: currentPage, section: 0)
            onBoardingCollectionView.scrollToItem(at: indexPathToScroll, at: .centeredHorizontally, animated: true)
            pageController.currentPage = currentPage
            if currentPage == data.count - 1 {
                contiuneButton.setTitle("Başla", for: .normal)
              }
            } else {
                handleOnboardingCompletion()
            }
        }
    }


//MARK: - PageController Configure

extension OnBoardingController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageController.currentPage = currentPage
        
    }
}

//MARK: - Configure CollectionView
extension OnBoardingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = onBoardingCollectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.identifier, for: indexPath) as! OnBoardingCell
        let onboardingData = data[indexPath.item]
        cell.imageView.image = UIImage(named: onboardingData.imageName)
        cell.titleLabel.text = onboardingData.title
        cell.descLabel.text = onboardingData.descTitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWith: CGFloat = onBoardingCollectionView.frame.width
        let cellHeight: CGFloat = onBoardingCollectionView.frame.height
        return .init(width: cellWith, height: cellHeight)
    }
}

//MARK: - Configure Constrain

extension OnBoardingController {
    
    func setupCons() {
        NSLayoutConstraint.activate([
            onBoardingCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            onBoardingCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            onBoardingCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            onBoardingCollectionView.bottomAnchor.constraint(equalTo: pageController.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            pageController.bottomAnchor.constraint(equalTo: contiuneButton.topAnchor, constant: -20),
            pageController.centerXAnchor.constraint(equalTo: contiuneButton.centerXAnchor),
            pageController.widthAnchor.constraint(equalTo: contiuneButton.widthAnchor),
            pageController.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            contiuneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -30),
            contiuneButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            contiuneButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -40),
            contiuneButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
