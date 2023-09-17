//
//  IncomeExpenseSummaryView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct IncomeExpenseSummaryView: View {
    @ObservedObject var transactionManager: TransactionManager

    // Déclarez et initialisez dateFormatter ici
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()

    var body: some View {
        let income = transactionManager.transactions.filter { $0.amount > 0 }.reduce(0) { $0 + $1.amount }
        let expenses = transactionManager.transactions.filter { $0.amount < 0 }.reduce(0) { $0 + $1.amount }

        VStack(alignment: .leading) {
            Text("Revenus: $\(income, specifier: "%.2f")")
            Text("Dépenses: $\(expenses, specifier: "%.2f")")
            Text("Solde: $\(income - expenses, specifier: "%.2f")")
        }
        
        List(transactionManager.transactions) { transaction in
            Text(transaction.description)
            Text("\(transaction.amount, specifier: "%.2f") €")
            Text("\(transaction.date, formatter: dateFormatter)")
        }
    }
}
