//
//  BudgetPlanningView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct BudgetPlanningView: View {
    @State private var income: Double = 0
    @State private var expenses: Double = 0
    @State private var budget: Double = 0
    @State private var budgetCalculated = false // Variable d'état pour suivre si le calcul a été effectué
    @State private var bills: [Bill] = [] // Modèle de données pour les factures
    let emptyTransactions: [Transaction] = []
    @ObservedObject var transactionManager: TransactionManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Planification de Budget")
                .font(.largeTitle)
                .padding()
            
            TextField("Revenu mensuel", value: $income, formatter: NumberFormatter())
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Dépenses mensuelles", value: $expenses, formatter: NumberFormatter())
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                // Calculez le budget disponible
                budget = income - expenses
                budgetCalculated = true // Indiquez que le calcul a été effectué
            }) {
                Text("Calculer le budget")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if budgetCalculated {
                if budget > 0 {
                    Text("Budget disponible: \(budget, specifier: "%.2f")")
                        .font(.headline)
                        .padding()
                } else if budget < 0 {
                    Text("Attention! Vous dépensez plus que ce que vous gagnez.")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.red)
                }
            }
            
            NavigationLink(destination: FinancialReportView(transactionManager: transactionManager)) {
                Text("Voir le Rapport Financier")
                    .foregroundColor(.blue)
            }
            
            NavigationLink(destination: BillManagementView(bills: $bills)) {
                Text("Gestion des Factures")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct BudgetPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        let transactionManager = TransactionManager() // Initialisez votre TransactionManager ici
        return BudgetPlanningView(transactionManager: transactionManager)
    }
}
