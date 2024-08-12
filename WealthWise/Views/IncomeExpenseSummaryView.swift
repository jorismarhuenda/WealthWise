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

        VStack(alignment: .leading, spacing: 20) {
            SummaryCardView(title: "Revenus", amount: income, color: .green)
            SummaryCardView(title: "Dépenses", amount: expenses, color: .red)
            SummaryCardView(title: "Solde", amount: income - expenses, color: .blue)

            Text("Détails des Transactions")
                .font(.headline)
                .padding(.top)

            List(transactionManager.transactions) { transaction in
                TransactionRowView(transaction: transaction, dateFormatter: dateFormatter)
            }
            .listStyle(PlainListStyle())
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct SummaryCardView: View {
    var title: String
    var amount: Double
    var color: Color

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(color)
            Spacer()
            Text("$\(amount, specifier: "%.2f")")
                .font(.title2)
                .foregroundColor(.primary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

struct TransactionRowView: View {
    var transaction: Transaction
    var dateFormatter: DateFormatter

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(transaction.description)
                    .font(.headline)
                Spacer()
                Text("\(transaction.amount, specifier: "%.2f") €")
                    .font(.subheadline)
                    .foregroundColor(transaction.amount >= 0 ? .green : .red)
            }
            Text("\(transaction.date, formatter: dateFormatter)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 5)
    }
}

struct IncomeExpenseSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let transactionManager = TransactionManager() // Assuming you have transactions set up here
        return IncomeExpenseSummaryView(transactionManager: transactionManager)
    }
}
