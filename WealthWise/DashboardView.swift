//
//  DashboardView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            Section(header: Text("Options")) {
                
                NavigationLink(destination: BudgetPlanningView()) {
                    Text("Planification Budgétaire")
                }
                
                NavigationLink(destination: WealthManagementView()) {
                    Text("Gestion de Patrimoine")
                }
                
                NavigationLink(destination: InvestmentAssistanceView()) {
                    Text("Aide à l'Investissement")
                }
                
                NavigationLink(destination: TransactionsView()) {
                                    Text("Transactions")
                                }
                                
                                NavigationLink(destination: MarketNewsAndUpdatesView()) {
                                    Text("Actualités et Mises à Jour du Marché")
                                }
                
                NavigationLink(destination: RetirementTrackerView()) {
                    Text("Suivi de la Retraite")
                }
            
            NavigationLink(destination: TransactionDetailView(transaction: TransactionDetail(id: UUID(),
                                                                                             beneficiary: "",
                                                                                             date: Date(),
                                                                                             amount: 150.0,
                                                                                             category: "",
                                                                                             notes: ""))) {
                Text("Détails de la Transaction")
            }
            
            NavigationLink(destination: DebtManagementView()) {
                                Text("Gestion de Dettes")
                            }
            
            NavigationLink(destination: FinancialReportView()) {
                                Text("Voir le Rapport Financier")
                                    .foregroundColor(.blue)
                            }
            
                Spacer()
            }
        .listStyle(GroupedListStyle())
            .navigationBarTitle("Tableau de Bord")
    }
}
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
