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
                
                NavigationLink(destination: InsuranceManagementView()) { // Lien vers la vue "Gestion des Assurances"
                                    Text("Gestion des Assurances")
                                }
                
                NavigationLink(destination: LoanManagementView()) {
                                   Text("Gestion des Prêts")
                               }
                
                NavigationLink(destination: SubscriptionManagementView()) {
                    Text("Gestion des Abonnements")
                }
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
