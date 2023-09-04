//
//  TransactionDetail.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct TransactionDetail {
    var id: UUID
    var beneficiary: String
    var date: Date
    var amount: Double
    var category: String
    var notes: String?
}
