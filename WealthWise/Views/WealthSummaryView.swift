//
//  WealthSummaryView.swift
//  WealthWise
//
//  Created by marhuenda joris on 05/09/2023.
//

import SwiftUI

struct WealthSummaryView: View {
    var body: some View {
        VStack {
            Text("Récapitulatif de Patrimoine")
                .font(.title)
                .padding()
            
            // Section Actifs
            VStack {
                Text("Actifs")
                    .font(.headline)
                
                // Afficher la liste des actifs de l'utilisateur
                // Vous pouvez utiliser une ScrollView si la liste est longue
                List {
                    WealthItemView(name: "Compte d'épargne", value: "$50,000")
                    WealthItemView(name: "Portefeuille d'actions", value: "$100,000")
                    // Ajoutez d'autres actifs ici
                }
            }
            .padding()
            
            // Section Dettes
            VStack {
                Text("Dettes")
                    .font(.headline)
                
                // Afficher la liste des dettes de l'utilisateur
                // Vous pouvez utiliser une ScrollView si la liste est longue
                List {
                    WealthItemView(name: "Prêt hypothécaire", value: "$200,000")
                    WealthItemView(name: "Carte de crédit", value: "$5,000")
                    // Ajoutez d'autres dettes ici
                }
            }
            .padding()
            
            // Section Valeur Nette
            VStack {
                Text("Valeur Nette")
                    .font(.headline)
                
                // Calculer la valeur nette en soustrayant les dettes des actifs
                Text("$150,000")
                    .font(.title)
                    .foregroundColor(.green)
            }
            .padding()
            
            Spacer()
        }
    }
}

struct WealthSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        WealthSummaryView()
    }
}

struct WealthItemView: View {
    let name: String
    let value: String
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(value)
                .foregroundColor(.green)
        }
    }
}
