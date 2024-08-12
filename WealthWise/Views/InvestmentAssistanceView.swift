//
//  InvestmentAssistanceView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct InvestmentAssistanceView: View {
    var body: some View {
        VStack(spacing: 25) {
            Text("Aide à l'Investissement")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .padding(.top, 40)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Investir intelligemment est essentiel pour faire fructifier votre argent. Voici quelques conseils :")
                    .font(.body)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.blue.opacity(0.1))
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .multilineTextAlignment(.center)
                
                // Liste de conseils d'investissement
                VStack(alignment: .leading, spacing: 15) {
                    Text("1. Diversifiez votre portefeuille pour réduire les risques.")
                    Text("2. Établissez des objectifs financiers clairs pour votre investissement.")
                    Text("3. Faites des recherches sur les investissements avant de prendre des décisions.")
                    Text("4. Consultez un conseiller financier pour des conseils professionnels.")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                )
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Pour en savoir plus sur l'investissement intelligent, consultez ces ressources :")
                    .font(.body)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.blue.opacity(0.1))
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .multilineTextAlignment(.center)
                
                // Liens vers des ressources externes
                VStack(spacing: 15) {
                    Link("Monpetitplacement pour investir intelligemment", destination: URL(string: "https://www.monpetitplacement.fr/fr/5-minutes-pour-comprendre-l-investissement/pourquoi-investir")!)
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Link("Conseils d'investissement de Warren Buffett", destination: URL(string: "https://www.berkshirehathaway.com/letters/letters.html")!)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            NavigationLink(destination: RiskAnalysisView()) {
                Text("Analyse de Risque")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarTitle("Aide à l'Investissement", displayMode: .inline)
    }
}

struct InvestmentAssistanceView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentAssistanceView()
    }
}
