//
//  FinancialReportView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct FinancialReportView: View {
    let recentTransactions: [Transaction] // Chargez les transactions récentes de l'utilisateur ici

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Rapport Financier")
                    .font(.title)
                
                // Graphique de répartition des dépenses
                PieChartView(dataPoints: expenseCategories) // Vous devez créer une vue PieChartView appropriée pour cela
                
                // Résumé des revenus et des dépenses
                HStack {
                    Text("Résumé des Revenus")
                        .font(.headline)
                    Spacer()
                }
                .padding(.bottom, 10)
                IncomeExpenseSummaryView(income: 5000, expenses: 3500, recentTransactions: recentTransactions) // Passez les transactions récentes
                
                // Liste des transactions récentes
                HStack {
                    Text("Transactions Récentes")
                        .font(.headline)
                    Spacer()
                }
                .padding(.bottom, 10)
                TransactionListView(transactions: recentTransactions) // Passez les transactions récentes
                
                // Graphique de suivi de la valeur nette au fil du temps
                HStack {
                    Text("Évolution de la Valeur Nette")
                        .font(.headline)
                    Spacer()
                }
                .padding(.bottom, 10)
                NetWorthChartView(dataPoints: netWorthDataPoints) // Vous devez créer une vue NetWorthChartView appropriée pour cela
            }
            .padding()
        }
        .navigationBarTitle("Rapport Financier")
    }
}


import SwiftUI

struct FinancialReportView_Previews: PreviewProvider {
    static var previews: some View {
        let emptyTransactions: [Transaction] = []
        
        return FinancialReportView(recentTransactions: emptyTransactions)
    }
}
