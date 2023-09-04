//
//  ExpenseCategory.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct ExpenseCategory: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
}
