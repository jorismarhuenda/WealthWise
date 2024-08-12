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
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .padding(.top, 20)

            if investments.isEmpty {
                Text("Aucun investissement trouvé.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(investments) { investment in
                            InvestmentCardView(investment: investment)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.top, 10)
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarTitle("Portfolio d'Investissement", displayMode: .inline)
    }
}

struct InvestmentCardView: View {
    var investment: Investment

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(investment.name)
                .font(.headline)
                .foregroundColor(.blue)

            HStack {
                Text("Quantité : \(investment.quantity)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Spacer()

                Text("Prix par unité : \(String(format: "%.2f", investment.pricePerUnit)) $")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
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

