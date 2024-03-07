//
//  LatitudeAndLongitudeModel.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 6.03.2024.
//


import Foundation

// MARK: - AllPharmacyModel
struct PharmacyModel: Codable {
    let status, message, messageTR: String?
    let systemTime: Int?
    let endpoint: String?
    let rowCount, creditUsed: Int?
    let data: [Cites]?
}

// MARK: - Datum
struct Cites: Codable {
    let pharmacyID: Int?
    let pharmacyName, address: String?
    let city: String?
    let district: String?
    let town, directions: String?
    let phone: String?
    let phone2, pharmacyDutyStart, pharmacyDutyEnd: String?
    let latitude, longitude: Double?
}


