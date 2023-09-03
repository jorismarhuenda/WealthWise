//
//  RetirementPlanningCalculator.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct RetirementPlanningCalculator: View {
    var body: some View {
        VStack {
            Text("Calculateur de Planification de Retraite")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Ajoutez ici des éléments pour permettre aux utilisateurs de simuler la planification de la retraite
        }
        .navigationBarTitle("Calculateur de Planification de Retraite")
    }
}

struct RetirementPlanningCalculator_Previews: PreviewProvider {
    static var previews: some View {
        RetirementPlanningCalculator()
    }
}
