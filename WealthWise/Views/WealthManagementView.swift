//
//  WealthManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct WealthManagementView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                Text("Gestion de Patrimoine")
                    .font(.title)
                
                NavigationLink(destination: WealthSummaryView()) { // Ajout du lien vers le récapitulatif de patrimoine
                                   Text("Récapitulatif de Patrimoine")
                               }
                
                NavigationLink(destination: InvestmentPortfolioView()) {
                    Text("Portfolio d'Investissement")
                }
                
                NavigationLink(destination: DebtManagementView()) {
                                    Text("Gestion de Dettes")
                                }
                
                NavigationLink(destination: SavingsPlanningView()) {
                                   Text("Planification de l'Épargne")
                               }
                
                NavigationLink(destination: InvestmentManagementView()) {
                    Text("Gestion des Investissements")
                }
                
                NavigationLink(destination: TaxTrackingView()) { // Ajout du lien vers TaxTrackingView
                                    Text("Suivi des Impôts")
                                }
                Spacer()
            }
            .padding()
            .navigationBarTitle("Gestion de Patrimoine")
    }
}
}

struct WealthManagementView_Previews: PreviewProvider {
    static var previews: some View {
        WealthManagementView()
    }
}
