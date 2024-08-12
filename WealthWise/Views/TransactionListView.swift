//
//  TransactionListView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var transactionManager: TransactionManager
    @State var transactions: [Transaction] = []
    
    var body: some View {
        List {
            ForEach(transactionManager.transactions) { transaction in
                TransactionCardView(transaction: transaction)
                    .padding(.vertical, 5)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let transactionToDelete = transactionManager.transactions[index]
                    transactionManager.deleteTransaction(transaction: transactionToDelete)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct TransactionCardView: View {
    var transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(transaction.description)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("€\(transaction.amount, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(transaction.amount < 0 ? .red : .green)
                .bold()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        )
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(transactionManager: TransactionManager())
    }
}

// Modèle de données factices pour l'évolution de la valeur nette au fil du temps
let netWorthDataPoints: [NetWorthDataPoint] = [
    NetWorthDataPoint(date: Date(), netWorth: 5000),
    NetWorthDataPoint(date: Date().addingTimeInterval(-86400), netWorth: 4800),
    NetWorthDataPoint(date: Date().addingTimeInterval(-172800), netWorth: 5200),
    // ... Ajoutez plus de points de données de valeur nette ...
]
