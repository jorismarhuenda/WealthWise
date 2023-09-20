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
            
            // Afficher la phrase seulement si un niveau de risque est sélectionné
            if let selectedRisk = riskLevels[safe: riskLevel] {
                Text("Votre profil de risque actuel : \(selectedRisk)")
                    .padding()
            }
            
            Picker(selection: $riskLevel, label: Text("Sélectionnez votre niveau de risque")) {
                ForEach(0 ..< riskLevels.count) { index in
                    Text(self.riskLevels[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Text("Description du niveau de risque :")
                .font(.headline)
                .padding(.top)
            
            // Afficher la description seulement si un niveau de risque est sélectionné
            if let selectedRisk = riskLevels[safe: riskLevel] {
                Text(selectedRiskDescription(selectedRisk))
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
    }
    
    // Fonction pour obtenir la description du niveau de risque sélectionné
    func selectedRiskDescription(_ risk: String) -> String {
        switch risk {
        case "Très Faible":
            return "Vous préférez des investissements très sûrs avec des rendements modestes."
        case "Faible":
            return "Vous préférez des investissements sécurisés, mais êtes ouvert à un peu plus de risque pour de meilleurs rendements."
        case "Modéré":
            return "Vous êtes prêt à prendre des risques modérés pour des rendements plus élevés."
        case "Élevé":
            return "Vous êtes à l'aise avec des niveaux de risque plus élevés pour des rendements potentiellement élevés."
        case "Très Élevé":
            return "Vous êtes prêt à prendre des risques importants pour la possibilité de rendements très élevés."
        default:
            return ""
        }
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

struct RiskAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        RiskAnalysisView()
    }
}
