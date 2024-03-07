//
//  CitiesService.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 6.03.2024.
//

import Foundation

enum CitiesEndPoint: String {
    case cities = "pharmacies-on-duty/cities"
    
    var path: String {
        switch self {
        case .cities:
            return NetworkHelper.shared.requestUrl(url: CitiesEndPoint.cities.rawValue)
        }
    }
}



