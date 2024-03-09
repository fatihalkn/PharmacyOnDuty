//
//  LatiAndLongService.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 7.03.2024.
//

import Foundation

protocol PharmacyModelServiceProtocol {
    func getPharmacy(city: String, disctrict: String, completion: @escaping ((PharmacyModel?,Error?) -> ()))
}

class PharmacyService {
    static let shared = PharmacyService()
}

extension PharmacyService: PharmacyModelServiceProtocol {
    func getPharmacy(city: String, disctrict: String, completion: @escaping ((PharmacyModel?, Error?) -> ())) {
        
        let pharmacyRequestUrl = NetworkHelper.shared.requestPharmacy(url: PharmacyModelEndPoint.latitudeAndLongitude.rawValue, cities: city, district: disctrict)
        print(pharmacyRequestUrl)
        NetworkManager.shared.request(type: PharmacyModel.self, url: pharmacyRequestUrl, method: .get) { result in
            switch result {
            case .success(let data):
                completion(data,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    
}

