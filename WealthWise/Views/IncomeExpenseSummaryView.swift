//
//  IncomeExpenseSummaryView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct IncomeExpenseSummaryView: View {
    let income: Double
    let expenses: Double

    var body: some View {
        VStack(alignment: .leading) {
            Text("Revenus: $\(income, specifier: "%.2f")")
            Text("Dépenses: $\(expenses, specifier: "%.2f")")
            Text("Solde: $\(income - expenses, specifier: "%.2f")")
        }
    }
}

// Modèle de données factices pour les transactions récentes
let recentTransactions: [Transaction] = [
    Transaction(description: "Épicerie", amount: -100, date: Date()),
    Transaction(description: "Salaire", amount: 3000, date: Date()),
    Transaction(description: "Loyer", amount: -1200, date: Date()),
    // ... Ajoutez plus de transactions ...
]
