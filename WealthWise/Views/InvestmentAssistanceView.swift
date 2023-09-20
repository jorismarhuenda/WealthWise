//
//  InvestmentAssistanceView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct InvestmentAssistanceView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Aide à l'Investissement")
                .font(.title)
            
            // Informations sur l'investissement intelligent
            Text("Investir intelligemment est essentiel pour faire fructifier votre argent. Voici quelques conseils :")
                .padding()
                .multilineTextAlignment(.center)
            
            // Liste de conseils d'investissement
            List {
                Text("1. Diversifiez votre portefeuille pour réduire les risques.")
                Text("2. Établissez des objectifs financiers clairs pour votre investissement.")
                Text("3. Faites des recherches sur les investissements avant de prendre des décisions.")
                Text("4. Consultez un conseiller financier pour des conseils professionnels.")
            }
            
            // Liens utiles
            Text("Pour en savoir plus sur l'investissement intelligent, consultez ces ressources :")
                .padding()
                .multilineTextAlignment(.center)
            
            // Liens vers des ressources externes
            Link("Monpetitplacement pour investir intelligemment", destination: URL(string: "https://www.monpetitplacement.fr/fr/5-minutes-pour-comprendre-l-investissement/pourquoi-investir")!)
            Link("Conseils d'investissement de Warren Buffett", destination: URL(string: "https://www.berkshirehathaway.com/letters/letters.html")!)
            
            NavigationLink(destination: RiskAnalysisView()) {
                Text("Analyse de Risque")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Aide à l'Investissement")
    }
}

struct InvestmentAssistanceView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentAssistanceView()
    }
}
