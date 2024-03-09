//
//  PharmaciesListModel.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 9.03.2024.
//

import Foundation

class PharmaciesListModel {
    
    let districtManager = PharmacyService.shared
    var successCallback: (()->())?
    var pharmacies: [Cites] = []
    
    func getDistrictPharmacy(selectedCity: String, selectedDisctrict: String) {
        districtManager.getPharmacy(city: selectedCity, disctrict: selectedDisctrict) { district, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let district = district?.data {
                    self.pharmacies = district
                    self.successCallback?()
                }
            }
        }
    }
}
