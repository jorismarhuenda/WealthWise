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
    let recentTransactions: [Transaction] // Chargez les transactions de l'utilisateur ici

    // Déclarez et initialisez dateFormatter ici
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Revenus: $\(income, specifier: "%.2f")")
            Text("Dépenses: $\(expenses, specifier: "%.2f")")
            Text("Solde: $\(income - expenses, specifier: "%.2f")")
        }
        
        List(recentTransactions) { transaction in
            Text(transaction.description)
            Text("\(transaction.amount, specifier: "%.2f") €")
            Text("\(transaction.date, formatter: dateFormatter)")
        }
    }
}

