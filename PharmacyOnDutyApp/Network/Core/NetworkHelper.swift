//
//  NetworkHelper.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 6.03.2024.
//curl --location 'https://www.nosyapi.com/apiv2/service/pharmacies-on-duty?apiKey=APIKEY'
//curl --location 'https://www.nosyapi.com/apiv2/service/pharmacies-on-duty/all?apiKey=APIKEY'
//curl --location 'https://www.nosyapi.com/apiv2/service/pharmacies-on-duty/locations?latitude=38.432561&longitude=27.143503&apiKey=APIKEY'
//curl --location 'https://www.nosyapi.com/apiv2/service/pharmacies-on-duty/cities?apiKey=APIKEY'

import Foundation

enum HTTPmethod: String {
    case get = "GET"
}

enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidURL = "Invalid URL"
    case genaralError = "An error happened"
}

class NetworkHelper {
    static let shared = NetworkHelper()
    
    let baseUrl = "https://www.nosyapi.com/apiv2/service/"
    let apıKey = "?apiKey=Ee6hcWuTWw50PZ1hLF79bVTBLijO3W9NWGQARML5GvsmNa0VNruBRmMr4wYO"
    
    func requestUrl(url: String) -> String {
        baseUrl + url + apıKey
    }
    
    func requestPharmacy(url: String, cities: String, district: String) -> String {
        baseUrl + url + apıKey + "&city=\(cities)" + "&city=\(cities)&district=\(district)"
    }
}
