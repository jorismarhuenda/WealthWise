//
//  InvestmentPortfolioView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct InvestmentPortfolioView: View {
    var body: some View {
        VStack {
            Text("Portfolio d'Investissement")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Ajoutez ici des éléments pour afficher le portefeuille d'investissement
        }
        .navigationBarTitle("Portfolio d'Investissement")
    }
}

struct InvestmentPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentPortfolioView()
    }
}
