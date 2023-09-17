//
//  FinancialReportView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct FinancialReportView: View {
    @ObservedObject var transactionManager: TransactionManager

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
                IncomeExpenseSummaryView(transactionManager: transactionManager)
                
                // Liste des transactions récentes
                HStack {
                    Text("Transactions Récentes")
                        .font(.headline)
                    Spacer()
                }
                .padding(.bottom, 10)
                TransactionListView(transactionManager: transactionManager)
                
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


struct FinancialReportView_Previews: PreviewProvider {
    static var previews: some View {
        let transactionManager = TransactionManager() // Initialisez un objet TransactionManager pour la prévisualisation
        
        return FinancialReportView( transactionManager: transactionManager)
    }
}

