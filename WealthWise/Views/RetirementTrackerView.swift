//
//  RetirementTrackerView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct RetirementTrackerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isPlanningRetirement = false
    
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
                
                Button(action: {
                                   isPlanningRetirement = true
                               }) {
                                   Text("Planifier la Retraite")
                                       .frame(width: 200, height: 50)
                                       .background(Color.blue)
                                       .foregroundColor(.white)
                                       .cornerRadius(10)
                               }
                Spacer()
            }
            .padding()
            .navigationBarTitle("Suivi de la Retraite")
            .sheet(isPresented: $isPlanningRetirement) {
                            // Affiche la vue de planification de la retraite en tant que feuille modale
                            RetirementPlanningView()
    }
}
}

struct RetirementTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        RetirementTrackerView()
    }
}
