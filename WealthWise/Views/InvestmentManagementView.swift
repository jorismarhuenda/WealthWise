//
//  InvestmentManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI

struct InvestmentManagementView: View {
    // Exemple de données pour le portefeuille d'investissement
    let portfolioItems = [
        Investment(name: "Actions Apple", symbol: "AAPL", quantity: 50, pricePerUnit: 150.0),
        Investment(name: "Actions Google", symbol: "GOOGL", quantity: 30, pricePerUnit: 2700.0),
        // Ajoutez d'autres investissements ici
    ]

    var body: some View {
        VStack {
            Text("Gestion des Investissements")
                .font(.title)
                .padding()

            List {
                ForEach(portfolioItems) { investment in
                    InvestmentRowView(investment: investment)
                }
            }

            Button(action: {
                // Action pour ajouter un nouvel investissement
            }) {
                Text("Ajouter un Investissement")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationBarTitle("Gestion des Investissements")
    }
}

struct InvestmentRowView: View {
    let investment: Investment

    var body: some View {
        HStack {
            Text(investment.name)
                .font(.headline)

            Spacer()

            Text("\(investment.quantity) actions")
                .foregroundColor(.gray)

            Text("\(investment.totalValue, specifier: "%.2f") €")
        }
        .padding()
    }
}

struct InvestmentManagementView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentManagementView()
    }
}
