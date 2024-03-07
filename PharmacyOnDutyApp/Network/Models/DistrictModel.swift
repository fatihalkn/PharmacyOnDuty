//
//  DistrictModel.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 7.03.2024.
//

import Foundation

// MARK: - DistrictModel
struct DistrictModel: Codable {
    let status, message, messageTR: String?
    let systemTime: Int?
    let endpoint: String?
    let rowCount, creditUsed: Int?
    let data: [District]?
}

// MARK: - Datum
struct District: Codable {
    let pharmacyID: Int?
    let pharmacyName, address, city, district: String?
    let town: String?
    let directions: String?
    let phone: String?
    let phone2, pharmacyDutyStart, pharmacyDutyEnd: String?
    let latitude, longitude: Double?
}
