//
//  AllPharmacyHelper.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 7.03.2024.
//

import Foundation

enum AllPharmacyEndPoint: String {
    case allPharmacy = "pharmacies-on-duty/all"
    
    
    var path: String {
        switch self {
        case .allPharmacy:
            return NetworkHelper.shared.requestUrl(url: AllPharmacyEndPoint.allPharmacy.rawValue)
        }
    }
}
