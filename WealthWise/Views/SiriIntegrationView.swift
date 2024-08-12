//
//  SiriIntegrationView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct SiriIntegrationView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Intégration de Siri")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .padding(.top, 20)
            
            Text("Bienvenue dans l'intégration de Siri de WealthWise.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Avec Siri, vous pouvez interagir avec votre application de gestion financière personnelle de manière vocale. Voici comment vous pouvez l'utiliser :")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 15) {
                HStack(alignment: .top) {
                    Image(systemName: "mic.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                        .padding(.trailing, 10)
                    Text("- Activez Siri en disant 'Hey Siri' suivi de votre commande. Par exemple, 'Hey Siri, montre-moi mon bilan financier.'")
                        .font(.body)
                        .foregroundColor(.primary)
                }
                
                HStack(alignment: .top) {
                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                        .padding(.trailing, 10)
                    Text("- Demandez à Siri de vous montrer des informations telles que vos dépenses, vos revenus, votre patrimoine, etc.")
                        .font(.body)
                        .foregroundColor(.primary)
                }
                
                HStack(alignment: .top) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                        .padding(.trailing, 10)
                    Text("- Vous pouvez même ajouter des transactions en disant 'Ajoute une transaction de 50 dollars à la catégorie alimentation.'")
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            )
            .padding(.horizontal)
            
            Text("N'hésitez pas à explorer les commandes vocales prises en charge et à demander à Siri de vous aider dans la gestion de vos finances.")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.gray.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarTitle("Intégration de Siri", displayMode: .inline)
    }
}

struct SiriIntegrationView_Previews: PreviewProvider {
    static var previews: some View {
        SiriIntegrationView()
    }
}
