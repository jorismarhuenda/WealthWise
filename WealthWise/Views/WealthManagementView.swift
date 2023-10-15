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
            VStack(spacing: 20) {
                
                NavigationLink(destination: WealthSummaryView()) {
                    WealthManagementItem(title: "Récapitulatif de Patrimoine", icon: "chart.pie.fill")
                }
                
                NavigationLink(destination: DebtManagementView()) {
                    WealthManagementItem(title: "Gestion de Dettes", icon: "creditcard.fill")
                }
                
                NavigationLink(destination: SavingsPlanningView()) {
                    WealthManagementItem(title: "Planification de l'Épargne", icon: "dollarsign.circle.fill")
                }
                
                NavigationLink(destination: InvestmentManagementView()) {
                    WealthManagementItem(title: "Gestion des Investissements", icon: "chart.bar.fill")
                }
                
                NavigationLink(destination: TaxTrackingView()) {
                    WealthManagementItem(title: "Suivi des Impôts", icon: "doc.text.fill")
                }
                
                NavigationLink(destination: InsuranceManagementView()) {
                    WealthManagementItem(title: "Gestion des Assurances", icon: "shield.fill")
                }
                
                NavigationLink(destination: LoanManagementView()) {
                    WealthManagementItem(title: "Gestion des Prêts", icon: "creditcard.fill")
                }
                
                NavigationLink(destination: SubscriptionManagementView()) {
                    WealthManagementItem(title: "Gestion des Abonnements", icon: "newspaper.fill")
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Gestion de Patrimoine")
        }
    }
}

struct WealthManagementItem: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding(8)
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                .shadow(radius: 5)
        )
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

struct WealthManagementView_Previews: PreviewProvider {
    static var previews: some View {
        WealthManagementView()
    }
}
