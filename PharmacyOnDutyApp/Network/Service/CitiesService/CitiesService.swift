//
//  CitiesService.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 6.03.2024.
//

import Foundation

protocol CitiesServiceProtocol {
    func getCities(completion: @escaping((CitiesModel?,Error?) ->() ))
    func getDistrict(city:String ,completion: @escaping ((CitiesModel?, Error?) -> ()))
}

class CitiesService {
    static let shared = CitiesService()
}

extension CitiesService: CitiesServiceProtocol {
    
    func getDistrict(city:String ,completion: @escaping ((CitiesModel?, Error?) -> ())) {
        let a = NetworkHelper.shared.requestDistcUrl(city: city)
        print(a)
        NetworkManager.shared.request(type: CitiesModel.self, url:  NetworkHelper.shared.requestDistcUrl(city: city)  , method: .get) { response in
            switch response {
            case .success(let data):
                completion(data,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    func getCities(completion: @escaping ((CitiesModel?, Error?) -> ())) {
        NetworkManager.shared.request(type: CitiesModel.self, url: NetworkHelper.shared.requestUrl(url: CitiesEndPoint.cities.rawValue), method: .get) { response in
            switch response {
            case .success(let data):
                completion(data,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    
}
