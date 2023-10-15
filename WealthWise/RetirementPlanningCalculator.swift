//
//  RetirementPlanningCalculator.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct RetirementPlanningCalculator: View {
    @State private var currentAge = ""
    @State private var retirementAge = ""
    @State private var currentIncome = ""
    @State private var currentSavings = ""
    @State private var expectedReturn = 5.0 // Taux de rendement par défaut en pourcentage
    
    @State private var estimatedRetirementSavings = ""
    @State private var estimatedRetirementIncome = ""
    
    var body: some View {
        VStack {
            
            TextField("Âge actuel", text: $currentAge)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Âge de la retraite prévu", text: $retirementAge)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Revenu actuel", text: $currentIncome)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Épargne-retraite existante", text: $currentSavings)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Affichage du pourcentage
            HStack {
                Text("Taux de Rendement Attendu: \(String(format: "%.1f", expectedReturn))%")
                Spacer()
            }
            .padding(.horizontal)
            
            Slider(value: $expectedReturn, in: 0...10, step: 0.5, minimumValueLabel: Text("0%"), maximumValueLabel: Text("10%")) {
                Text("Taux de Rendement Attendu")
            }
            .padding()
            
            Button(action: calculateRetirement) {
                Text("Calculer")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            // Affichage des résultats
            Text("Épargne-retraite estimée: \(estimatedRetirementSavings)")
                .padding()
            
            Text("Revenu de retraite estimé: \(estimatedRetirementIncome)")
                .padding()
        }
        .navigationBarTitle("Calculateur de Planification de Retraite")
    }
    
    func calculateRetirement() {
        guard let currentAgeValue = Double(currentAge),
              let retirementAgeValue = Double(retirementAge),
              let currentIncomeValue = Double(currentIncome),
              let currentSavingsValue = Double(currentSavings) else {
            return // Gérer les erreurs de saisie d'utilisateur ici
        }
        
        let yearsToRetirement = retirementAgeValue - currentAgeValue
        let futureSavings = currentSavingsValue * pow(1 + expectedReturn / 100, yearsToRetirement)
        let futureIncome = (futureSavings * expectedReturn / 100) + (currentIncomeValue * yearsToRetirement)
        
        estimatedRetirementSavings = String(format: "%.2f", futureSavings)
        estimatedRetirementIncome = String(format: "%.2f", futureIncome)
    }
}

struct RetirementPlanningCalculator_Previews: PreviewProvider {
    static var previews: some View {
        RetirementPlanningCalculator()
    }
}
