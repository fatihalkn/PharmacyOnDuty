//
//  CitiesService.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 6.03.2024.
//

import Foundation

protocol CitiesServiceProtocol {
    func getCities(completion: @escaping((CitiesModel?,Error?) ->() ))
}

class CitiesService {
    static let shared = CitiesService()
}

extension CitiesService: CitiesServiceProtocol {
    func getCities(completion: @escaping ((CitiesModel?, Error?) -> ())) {
        NetworkManager.shared.request(type: CitiesModel.self, url: CitiesEndPoint.cities.path, method: .get) { response in
            switch response {
            case .success(let data):
                completion(data,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    
}
