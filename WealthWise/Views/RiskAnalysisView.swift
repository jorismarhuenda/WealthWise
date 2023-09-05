//
//  RiskAnalysisView.swift
//  WealthWise
//
//  Created by marhuenda joris on 05/09/2023.
//

import SwiftUI

struct RiskAnalysisView: View {
    @State private var riskLevel: Int = 3 // Niveau de risque par défaut, peut être ajusté par l'utilisateur
    let riskLevels = ["Très Faible", "Faible", "Modéré", "Élevé", "Très Élevé"]
    
    var body: some View {
        VStack {
            Text("Analyse de Risque")
                .font(.title)
            
            Text("Votre profil de risque actuel : \(riskLevels[riskLevel])")
                .padding()
            
            Picker(selection: $riskLevel, label: Text("Sélectionnez votre niveau de risque")) {
                ForEach(0 ..< riskLevels.count) { index in
                    Text(self.riskLevels[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Text("Description de chaque niveau de risque :")
                .font(.headline)
                .padding(.top)
            
            Text("Très Faible : Vous préférez des investissements très sûrs avec des rendements modestes.")
                .padding(.horizontal)
            
            Text("Faible : Vous préférez des investissements sécurisés, mais êtes ouvert à un peu plus de risque pour de meilleurs rendements.")
                .padding(.horizontal)
            
            Text("Modéré : Vous êtes prêt à prendre des risques modérés pour des rendements plus élevés.")
                .padding(.horizontal)
            
            Text("Élevé : Vous êtes à l'aise avec des niveaux de risque plus élevés pour des rendements potentiellement élevés.")
                .padding(.horizontal)
            
            Text("Très Élevé : Vous êtes prêt à prendre des risques importants pour la possibilité de rendements très élevés.")
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

struct RiskAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        RiskAnalysisView()
    }
}
