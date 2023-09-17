//
//  DashboardView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.presentationMode) var presentationMode
    let transactionManager = TransactionManager()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
            
                
                NavigationLink(destination: BudgetPlanningView(transactionManager: transactionManager)) {
                    Text("Planification Budgétaire")
                }
                
                NavigationLink(destination: WealthManagementView()) {
                    Text("Gestion de Patrimoine")
                }
                
                NavigationLink(destination: InvestmentAssistanceView()) {
                    Text("Aide à l'Investissement")
                }
                
                NavigationLink(destination: TransactionsView(transactionManager: transactionManager)) {
                    Text("Transactions")
                }
                                
                                NavigationLink(destination: MarketNewsAndUpdatesView()) {
                                    Text("Marchés Boursiers en Direct")
                                }
                
                NavigationLink(destination: RetirementTrackerView()) {
                    Text("Suivi de la Retraite")
                }
            }
        .listStyle(GroupedListStyle())
            .navigationBarTitle("Tableau de Bord")
    }
}
}

    
struct DashboardListItem: View {
    let title: String
    let image: String

    var body: some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
            
            Text(title)
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
