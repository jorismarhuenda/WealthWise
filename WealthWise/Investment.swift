//
//  Investment.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI

struct Investment: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let quantity: Int
    let pricePerUnit: Double

    var totalValue: Double {
        return Double(quantity) * pricePerUnit
    }
}
