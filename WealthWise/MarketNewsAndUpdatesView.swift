//
//  MarketNewsAndUpdatesView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct MarketNewsAndUpdatesView: View {
    var body: some View {
        VStack {
            Text("Actualités et Mises à Jour du Marché")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Ajoutez ici des éléments pour afficher les actualités financières et les mises à jour du marché
        }
        .navigationBarTitle("Actualités et Mises à Jour du Marché")
    }
}

struct MarketNewsAndUpdatesView_Previews: PreviewProvider {
    static var previews: some View {
        MarketNewsAndUpdatesView()
    }
}
