//
//  NetWorthDataPoint.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct NetWorthDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let netWorth: Double
}
