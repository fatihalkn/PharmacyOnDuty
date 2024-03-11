//
//  MapControllerViewModel.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 11.03.2024.
//

import Foundation

class MapControllerViewModel {
    let latitudeAndLongitudeManager = LatitudeAndLongitudeService.shared
    var successCallback: (()->())?
    var latitudeAndLongitude: [Cites] = []
    
    func getLatitudeAndLongitude(latitude: Double, longitude: Double) {
        latitudeAndLongitudeManager.getLatitudeAndLongitude(latitude: latitude, longitude: longitude) { result, error  in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let latitudeAndLongitude = result?.data {
                    self.latitudeAndLongitude = latitudeAndLongitude
                    self.successCallback?()
                }
            }
        }
        
    }
    
}
