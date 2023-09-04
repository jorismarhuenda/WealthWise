//
//  FinancialReportView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct FinancialReportView: View {
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
                IncomeExpenseSummaryView(income: 5000, expenses: 3500) // Créez une vue IncomeExpenseSummaryView pour afficher ces informations
                
                // Liste des transactions récentes
                HStack {
                    Text("Transactions Récentes")
                        .font(.headline)
                    Spacer()
                }
                .padding(.bottom, 10)
                TransactionListView(transactions: recentTransactions) // Créez une vue TransactionListView pour afficher ces informations
                
                // Graphique de suivi de la valeur nette au fil du temps
                HStack {
                    Text("Évolution de la Valeur Nette")
                        .font(.headline)
                    Spacer()
                }
                .padding(.bottom, 10)
                NetWorthChartView(dataPoints: netWorthDataPoints) // Créez une vue NetWorthChartView pour afficher ces informations
            }
            .padding()
        }
        .navigationBarTitle("Rapport Financier")
    }
}

struct FinancialReportView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialReportView()
    }
}
