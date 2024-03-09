//
//  PickerViewModel.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 8.03.2024.
//

import Foundation

final class PickerViewModel {

    var successCallback: (()->())?
    
    var disctricts: [Datum] = []
    
    let allCityManager = CitiesService.shared
    
    func getDistrict(selectedCity: String) {
        allCityManager.getDistrict(city: selectedCity) { dist, error  in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let district = dist?.data {
                    self.disctricts = district
                    self.successCallback?()
                }
            }
        }
    }

}
