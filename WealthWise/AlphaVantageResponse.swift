//
//  AlphaVantageResponse.swift
//  WealthWise
//
//  Created by marhuenda joris on 08/09/2023.
//

import Foundation

struct AlphaVantageResponse: Codable {
    let metaData: MetaData?
    let timeSeries: [String: [String: String]]?

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries = "Time Series (5min)"
    }
}

struct MetaData: Codable {
    let symbol: String?
    let companyName: String?

    enum CodingKeys: String, CodingKey {
        case symbol = "2. Symbol"
        case companyName = "1. Information"
    }
}
