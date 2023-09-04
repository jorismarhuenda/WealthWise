//
//  TransactionListView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct TransactionListView: View {
    let transactions: [Transaction]

    var body: some View {
        List(transactions) { transaction in
            VStack(alignment: .leading) {
                Text(transaction.description)
                Text("$\(transaction.amount, specifier: "%.2f")")
                    .foregroundColor(transaction.amount < 0 ? .red : .green)
            }
        }
    }
}

// Modèle de données factices pour l'évolution de la valeur nette au fil du temps
let netWorthDataPoints: [NetWorthDataPoint] = [
    NetWorthDataPoint(date: Date(), netWorth: 5000),
    NetWorthDataPoint(date: Date().addingTimeInterval(-86400), netWorth: 4800),
    NetWorthDataPoint(date: Date().addingTimeInterval(-172800), netWorth: 5200),
    // ... Ajoutez plus de points de données de valeur nette ...
]
