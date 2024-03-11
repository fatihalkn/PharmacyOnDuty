//
//  LatitudeAndLongitudeService.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 11.03.2024.
//

import Foundation

protocol LatitudeAndLongitudeServiceProtocol {
    func getLatitudeAndLongitude(latitude: Double, longitude: Double,completion: @escaping ((PharmacyModel?,Error?) -> ()))
}

class LatitudeAndLongitudeService {
    static let shared = LatitudeAndLongitudeService()
}

extension LatitudeAndLongitudeService: LatitudeAndLongitudeServiceProtocol {
    func getLatitudeAndLongitude(latitude: Double, longitude: Double, completion: @escaping ((PharmacyModel?, Error?) -> ())) {
        let LatitudeAndLongitudeUrl = NetworkHelper.shared.requestLatitudeAndLongitude(url: LatitudeAndLongitudeEndPoint.latitudeAndLongitude.rawValue, latitude: latitude, longitude: longitude)
        print(LatitudeAndLongitudeUrl)
        NetworkManager.shared.request(type: PharmacyModel.self, url: LatitudeAndLongitudeUrl, method: .get) { result in
            switch result {
            case .success(let data):
                completion(data,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    
    
}
