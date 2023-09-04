//
//  ExpenseTrackerView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct ExpenseTrackerView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Suivi des Dépenses")
                .font(.title)
            
            // Ajoutez ici des éléments pour permettre à l'utilisateur de suivre ses dépenses, par exemple :
            // - Liste des transactions
            // - Graphique de répartition des dépenses par catégorie
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Suivi des Dépenses")
    }
}

struct ExpenseTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseTrackerView()
    }
}
