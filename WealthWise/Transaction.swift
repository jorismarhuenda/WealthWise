//
//  Transaction.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    let description: String
    let amount: Double
    let date: Date
}
