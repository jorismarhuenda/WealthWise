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
                    DashboardListItem(title: "Planification Budgétaire", image: "chart.pie.fill")
                }
                
                NavigationLink(destination: WealthManagementView()) {
                    DashboardListItem(title: "Gestion de Patrimoine", image: "banknote.fill")
                }
                
                NavigationLink(destination: InvestmentAssistanceView()) {
                    DashboardListItem(title: "Aide à l'Investissement", image: "arrow.up.arrow.down.circle.fill")
                }
                
                NavigationLink(destination: TransactionsView(transactionManager: transactionManager)) {
                    DashboardListItem(title: "Transactions", image: "creditcard.fill")
                }
                
                NavigationLink(destination: MarketNewsAndUpdatesView()) {
                    DashboardListItem(title: "Marchés Boursiers en Direct", image: "newspaper.fill")
                }
                
                NavigationLink(destination: RetirementTrackerView()) {
                    DashboardListItem(title: "Suivi de la Retraite", image: "chart.bar.fill")
                }
            }
            .padding()
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Tableau de Bord")
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
                .foregroundColor(Color.blue)
            
            Text(title)
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: 1)
        )
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
