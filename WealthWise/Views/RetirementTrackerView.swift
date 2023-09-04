//
//  RetirementTrackerView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct RetirementTrackerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            VStack(spacing: 20) {
                Text("Suivi de la Retraite")
                    .font(.title)
                
                NavigationLink(destination: RetirementPlanningCalculator()) {
                    Text("Calculateur de Planification de Retraite")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // Ajoutez des éléments pour permettre à l'utilisateur de suivre sa retraite
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Suivi de la Retraite")
    }
}

struct RetirementTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        RetirementTrackerView()
    }
}
