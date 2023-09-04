//
//  SavingsPlanningView.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI

struct SavingsPlanningView: View {
    @State private var shortTermGoal: Double = 0
    @State private var longTermGoal: Double = 0
    @State private var currentSavings: Double = 0

    var body: some View {
        VStack {
            Text("Planification de l'Épargne")
                .font(.title)
                .padding()

            Spacer()

            Text("Objectif d'Épargne à Court Terme")
                .font(.headline)
                .padding()

            TextField("Montant en euros", value: $shortTermGoal, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Text("Objectif d'Épargne à Long Terme")
                .font(.headline)
                .padding()

            TextField("Montant en euros", value: $longTermGoal, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Text("Économies Actuelles")
                .font(.headline)
                .padding()

            TextField("Montant en euros", value: $currentSavings, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Spacer()

            Button(action: {
                // Ajoutez ici la logique pour enregistrer les objectifs d'épargne et les économies actuelles
                // Vous pouvez calculer la progression et afficher un message de confirmation
            }) {
                Text("Enregistrer")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct SavingsPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        SavingsPlanningView()
    }
}
