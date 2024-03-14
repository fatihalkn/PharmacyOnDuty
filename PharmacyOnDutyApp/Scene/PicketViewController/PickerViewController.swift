//
//  PickerViewController.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 8.03.2024.
//

import Foundation
import UIKit

protocol PickerViewButtonDelegate {
    func clickedOkButton(city: String, district: String)
}

class PickerViewController: UIViewController {
    
    var pickerViewDelegate: PickerViewButtonDelegate?
    
    let pickerViewModel = PickerViewModel()
    
    var city: String?
        
    private let districtPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private let pickerCancelButtons: UIButton = {
        let button = UIButton()
        button.setTitle("İptal", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pickerOkButtons: UIButton = {
        let button = UIButton()
        button.setTitle("Tamam", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        isSucceed()
        setupUI()
        setupDelegate()
        pickerViewCons()
        pickerOkButtonCons()
        pickerCancelButtonCons()
        buttonTargets()
        view.backgroundColor = .white
        navigationItem.title = "Lütfen İlçenizi Seçiniz"
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureRadius()
    }
    
    func buttonTargets() {
        pickerOkButtons.addTarget(self, action: #selector(clickedOkButton), for: .touchUpInside)
        pickerCancelButtons.addTarget(self, action: #selector(clickedCancelButton), for: .touchUpInside)
    }
    
    @objc func clickedOkButton() {
        let selectedRow = districtPickerView.selectedRow(inComponent: 0)
        let selectedDisctrict = pickerViewModel.disctricts[selectedRow].slug
        let selectedCity = city ?? ""
        dismiss(animated: true) {
            self.pickerViewDelegate?.clickedOkButton(city: selectedCity, district: selectedDisctrict)
        }
    }

    
    @objc func clickedCancelButton() {
        print("İPTAL BUTONUNA BASTIN")
        self.dismiss(animated: true,completion: nil)
        
    }
    
    func configureRadius() {
        pickerOkButtons.layer.cornerRadius = pickerOkButtons.frame.height / 2
        pickerOkButtons.layer.masksToBounds = true
        
        pickerCancelButtons.layer.cornerRadius = pickerCancelButtons.frame.height / 2
        pickerCancelButtons.layer.masksToBounds = true
    }
    
    func setupDelegate() {
        districtPickerView.delegate = self
        districtPickerView.dataSource = self
    }
    
    func setupUI() {
        view.addSubview(districtPickerView)
        view.addSubview(pickerOkButtons)
        view.addSubview(pickerCancelButtons)
    }
    
    func getData() {
        guard let city = city else { return }
        print(city)
        pickerViewModel.getDistrict(selectedCity: city)
    }
    
    func isSucceed() {
        pickerViewModel.successCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.districtPickerView.reloadAllComponents()
            }
        }
        
    }
}

//MARK: - Configure PickerView
extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewModel.disctricts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewModel.disctricts[row].cities
    }
}

//MARK: - Configure Cons
extension PickerViewController {
    
    func pickerViewCons() {
        NSLayoutConstraint.activate([
            districtPickerView.topAnchor.constraint(equalTo: pickerOkButtons.bottomAnchor),
            districtPickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            districtPickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            districtPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func pickerCancelButtonCons() {
        NSLayoutConstraint.activate([
            pickerCancelButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            pickerCancelButtons.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50),
            pickerCancelButtons.leadingAnchor.constraint(greaterThanOrEqualTo:view.safeAreaLayoutGuide.centerXAnchor),
            pickerCancelButtons.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func pickerOkButtonCons() {
        NSLayoutConstraint.activate([
            pickerOkButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            pickerOkButtons.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50),
            pickerOkButtons.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.centerXAnchor),
            pickerOkButtons.heightAnchor.constraint(equalToConstant: 30),
            
        ])
        
    }
    
    
}
