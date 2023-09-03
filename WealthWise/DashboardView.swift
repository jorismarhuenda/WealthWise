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
        VStack(spacing: 20) {
                Text("Tableau de Bord")
                    .font(.title)
                
                NavigationLink(destination: BudgetPlanningView()) {
                    Text("Planification Budgétaire")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: WealthManagementView()) {
                    Text("Gestion de Patrimoine")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: InvestmentAssistanceView()) {
                    Text("Aide à l'Investissement")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: TransactionsView()) {
                                    Text("Transactions")
                                        .frame(width: 200, height: 50)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                
                                NavigationLink(destination: MarketNewsAndUpdatesView()) {
                                    Text("Actualités et Mises à Jour du Marché")
                                        .frame(width: 200, height: 50)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                
                NavigationLink(destination: RetirementTrackerView()) {
                    Text("Suivi de la Retraite")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Tableau de Bord")
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
