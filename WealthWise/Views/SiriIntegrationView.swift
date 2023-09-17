//
//  SiriIntegrationView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct SiriIntegrationView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Intégration de Siri")
                .font(.title)
            
            Text("Bienvenue dans l'intégration de Siri de WealthWise.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Avec Siri, vous pouvez interagir avec votre application de gestion financière personnelle de manière vocale. Voici comment vous pouvez l'utiliser :")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("- Activez Siri en disant 'Hey Siri' suivi de votre commande. Par exemple, 'Hey Siri, montre-moi mon bilan financier.'")
                Text("- Demandez à Siri de vous montrer des informations telles que vos dépenses, vos revenus, votre patrimoine, etc.")
                Text("- Vous pouvez même ajouter des transactions en disant 'Ajoute une transaction de 50 dollars à la catégorie alimentation.'")
            }
            .font(.body)
            .padding()
            
            Text("N'hésitez pas à explorer les commandes vocales prises en charge et à demander à Siri de vous aider dans la gestion de vos finances.")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Intégration de Siri")
    }
}

struct SiriIntegrationView_Previews: PreviewProvider {
    static var previews: some View {
        SiriIntegrationView()
    }
}
