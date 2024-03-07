//
//  AllPharmacyManager.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 7.03.2024.
//

import Foundation

protocol AllPharmacyServiceProtocol {
    func getAllPharmacy(completion: @escaping((AllPharmacyModel?,Error?)-> ()))
}

class AllPharmacyService {
    static let shared = AllPharmacyService()
    
}

extension AllPharmacyService: AllPharmacyServiceProtocol {
    func getAllPharmacy(completion: @escaping ((AllPharmacyModel?, Error?)-> ())) {
        NetworkManager.shared.request(type: AllPharmacyModel.self, url: AllPharmacyEndPoint.allPharmacy.path, method: .get) { response in
            switch response {
            case .success(let data):
                completion(data,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
}
