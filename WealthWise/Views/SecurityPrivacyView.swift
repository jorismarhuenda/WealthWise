//
//  SecurityPrivacyView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct SecurityPrivacyView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Sécurité et Confidentialité")
                    .font(.title)
                
                Text("Chez WealthWise, la sécurité et la confidentialité de vos données sont notre priorité.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                Text("Voici quelques-unes des mesures que nous prenons pour protéger vos informations financières :")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                
                SecurityFeatureView(icon: "lock.shield.fill", title: "Sécurité des Données", description: "Vos données sont cryptées et stockées de manière sécurisée.")
                SecurityFeatureView(icon: "faceid", title: "Authentification Biométrique", description: "Utilisez la reconnaissance faciale ou l'empreinte digitale pour sécuriser l'accès à votre compte.")
                SecurityFeatureView(icon: "creditcard.fill", title: "Transactions Sécurisées", description: "Toutes les transactions sont sécurisées avec des protocoles de chiffrement avancés.")
                
                Text("Nous respectons également votre vie privée. Consultez notre politique de confidentialité pour en savoir plus sur la collecte et l'utilisation de vos données.")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Sécurité et Confidentialité", displayMode: .inline)
    }
}

struct SecurityFeatureView: View {
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct SecurityPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SecurityPrivacyView()
        }
    }
}
