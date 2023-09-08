//
//  MarketData.swift
//  WealthWise
//
//  Created by marhuenda joris on 08/09/2023.
//

import Foundation

struct StockData: Identifiable {
    let id = UUID()
    let symbol: String
    let companyName: String
    let latestPrice: Double
    let change: Double
    let changePercentage: Double
}
