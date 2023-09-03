//
//  BudgetPlanningView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct BudgetPlanningView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Planification Budgétaire")
                .font(.title)
            
            // Ajoutez ici des éléments pour permettre à l'utilisateur de créer et de gérer son budget
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Planification Budgétaire")
    }
}

struct BudgetPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetPlanningView()
    }
}
