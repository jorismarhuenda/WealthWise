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
            VStack(spacing: 25) {
                
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
            .navigationBarTitle("Gestion de Patrimoine", displayMode: .inline)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct WealthManagementItem: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 50, height: 50)
                    .shadow(color: Color.blue.opacity(0.4), radius: 5, x: 0, y: 5)
                
                Image(systemName: icon)
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
            }
            
            Text(title)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.blue)
            
            Spacer()
        }
        .padding()
        .background(
            VisualEffectBlur(blurStyle: .systemMaterial)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
}

struct WealthManagementView_Previews: PreviewProvider {
    static var previews: some View {
        WealthManagementView()
    }
}
