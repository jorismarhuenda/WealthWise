//
//  WealthManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct WealthManagementView: View {
    var body: some View {
            VStack(spacing: 20) {
                Text("Gestion de Patrimoine")
                    .font(.title)
                
                NavigationLink(destination: WealthSummaryView()) { // Ajout du lien vers le récapitulatif de patrimoine
                                   Text("Récapitulatif de Patrimoine")
                                       .frame(width: 200, height: 50)
                                       .background(Color.blue)
                                       .foregroundColor(.white)
                                       .cornerRadius(10)
                               }
                
                NavigationLink(destination: InvestmentPortfolioView()) {
                    Text("Portfolio d'Investissement")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: DebtManagementView()) {
                                    Text("Gestion de Dettes")
                                        .frame(width: 200, height: 50)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                
                NavigationLink(destination: SavingsPlanningView()) {
                                   Text("Planification de l'Épargne")
                                       .frame(width: 200, height: 50)
                                       .background(Color.blue)
                                       .foregroundColor(.white)
                                       .cornerRadius(10)
                               }
                
                NavigationLink(destination: InvestmentManagementView()) {
                    Text("Gestion des Investissements")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Gestion de Patrimoine")
    }
}

struct WealthManagementView_Previews: PreviewProvider {
    static var previews: some View {
        WealthManagementView()
    }
}
