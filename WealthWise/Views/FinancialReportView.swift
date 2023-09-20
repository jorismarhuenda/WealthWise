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
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                // Graphique de répartition des dépenses
                PieChartView(dataPoints: expenseCategories)
                    .frame(height: 200) // Réglez la hauteur du graphique
                
                // Résumé des revenus et des dépenses
                Section(header: Text("Résumé des Revenus et des Dépenses").font(.headline)) {
                    IncomeExpenseSummaryView(transactionManager: transactionManager)
                }

                // Liste des transactions récentes
                Section(header: Text("Transactions Récentes").font(.headline)) {
                    TransactionListView(transactionManager: transactionManager)
                }

                // Graphique de suivi de la valeur nette au fil du temps
                Section(header: Text("Évolution de la Valeur Nette").font(.headline)) {
                    NetWorthChartView(dataPoints: netWorthDataPoints)
                        .frame(height: 200) // Réglez la hauteur du graphique
                }
            }
            .padding()
        }
        .navigationBarTitle("Rapport Financier", displayMode: .inline)
    }
}

struct FinancialReportView_Previews: PreviewProvider {
    static var previews: some View {
        let transactionManager = TransactionManager() // Initialisez un objet TransactionManager pour la prévisualisation
        
        return FinancialReportView( transactionManager: transactionManager)
    }
}

