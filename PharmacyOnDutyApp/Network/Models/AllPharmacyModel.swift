//
//  AllPharmacyModel.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 6.03.2024.
//
import Foundation

// MARK: - AllPharmacyModel
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let allPharmacyModel = try? JSONDecoder().decode(AllPharmacyModel.self, from: jsonData)

import Foundation

// MARK: - AllPharmacyModel
struct AllPharmacyModel: Codable {
    let status, message, messageTR: String?
    let systemTime: Int?
    let endpoint: String?
    let rowCount, creditUsed: Int?
    let data: [Pharmacy]?
}

// MARK: - Datum
struct Pharmacy: Codable {
    let pharmacyID: Int?
    let pharmacyName, address, city, district: String?
    let town, directions: String?
    let phone: String?
    let phone2: String?
    let pharmacyDutyStart, pharmacyDutyEnd: String?
    let latitude, longitude: Double?
}

enum Phone2: String, Codable{
    case empty
    case the02365151463
    case the02524121880
    case the02588511111
    case the02663333033
    case the02762247254
    case the03128661233
    case the03224354835
    case the03228262422
    case the03262214626
    case the03445119116
    case the03543686141
    case the03547161746
    case the03707664200
    case the03822216688
    case the04326512088
    case the04463113404
    case the04628415807
    case the04842233537
    case the05066357537
    case the05077069791
    case the05322000488
    case the05327976181
    case the05452134463
    case the05466870936
}
