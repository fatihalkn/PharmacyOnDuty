//
//  HomeViewModel.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 7.03.2024.
//

import Foundation

class HomeViewModel {
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
        
    let manager = CitiesService.shared
    
    var cities: [Datum] = []
    
    func getAllCity() {
        manager.getCities { city, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let cities = city?.data {
                    self.cities = cities
                    self.successCallback?()
                }
            }
        }
        
    }
}


