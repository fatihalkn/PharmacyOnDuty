//
//  CitiesModel.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 6.03.2024.
//

import Foundation



import Foundation

// MARK: - Welcome5
struct CitiesModel: Codable {
    let status, message, messageTR: String
    let systemTime: Int
    let endpoint: String
    let rowCount, creditUsed: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let cities, slug: String
}

