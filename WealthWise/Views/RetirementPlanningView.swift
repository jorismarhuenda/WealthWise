//
//  RetirementPlanningView.swift
//  WealthWise
//
//  Created by marhuenda joris on 05/09/2023.
//

import SwiftUI

struct RetirementPlanningView: View {
    @State private var currentAge = 30
    @State private var retirementAge = 65
    @State private var currentSavings = 100000
    @State private var monthlySavings = 1000
    @State private var estimatedExpenses = 50000
    
    var body: some View {
        VStack {
            Text("Planification de la Retraite")
                .font(.title)
                .padding()
            
            Form {
                Section(header: Text("Informations de base")) {
                    TextField("Âge actuel", value: $currentAge, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    TextField("Âge de la retraite souhaité", value: $retirementAge, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Économies et épargne")) {
                    TextField("Économies actuelles pour la retraite", value: $currentSavings, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    TextField("Épargne mensuelle", value: $monthlySavings, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Estimations de dépenses à la retraite")) {
                    TextField("Dépenses annuelles estimées à la retraite", value: $estimatedExpenses, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
            }
            
            Button(action: {
                // Calculs de planification de la retraite ici
                // Vous pouvez ajouter votre logique de calcul ici
            }) {
                Text("Calculer")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarTitle("Planification de la Retraite")
    }
}

struct RetirementPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        RetirementPlanningView()
    }
}
