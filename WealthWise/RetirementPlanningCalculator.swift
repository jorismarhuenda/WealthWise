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
            
            InputField(title: "Âge actuel", text: $currentAge)
            InputField(title: "Âge de la retraite prévu", text: $retirementAge)
            InputField(title: "Revenu actuel", text: $currentIncome)
            InputField(title: "Épargne-retraite existante", text: $currentSavings)
            
            Slider(value: $expectedReturn, in: 0...10, step: 0.5)
                .padding()
            
            Button(action: calculateRetirement) {
                Text("Calculer")
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            ResultView(title: "Épargne-retraite estimée:", value: estimatedRetirementSavings)
            ResultView(title: "Revenu de retraite estimé:", value: estimatedRetirementIncome)
            
            Spacer()
        }
        .padding()
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

struct InputField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        TextField(title, text: $text)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ResultView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(value)
                .font(.headline)
        }
        .padding()
    }
}
