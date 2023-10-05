//
//  InvestmentPortfolioView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct InvestmentPortfolioView: View {
    var investments: [Investment]

    var body: some View {
        VStack {
            Text("Portfolio d'Investissement")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            if investments.isEmpty {
                Text("Aucun investissement trouvé.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(investments) { investment in
                        InvestmentRowView(investment: investment)
                    }
                }
            }
        }
        .navigationBarTitle("Portfolio d'Investissement")
    }
}

struct InvestmentPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        // Créez des investissements de test pour la prévisualisation
        let testInvestments = [
            Investment(id: "1", name: "Apple Inc.", quantity: 10, pricePerUnit: 150.0, userId: "user1"),
            Investment(id: "2", name: "Microsoft Corp.", quantity: 5, pricePerUnit: 300.0, userId: "user1")
            // Ajoutez d'autres investissements de test si nécessaire
        ]

        return InvestmentPortfolioView(investments: testInvestments)
            .previewDevice("iPhone 12 Pro")
    }
}
