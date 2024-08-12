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
            VStack(spacing: 30) {
                Text("Sécurité et Confidentialité")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.blue)
                    .padding(.top, 20)
                
                Text("Chez WealthWise, la sécurité et la confidentialité de vos données sont notre priorité.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text("Voici quelques-unes des mesures que nous prenons pour protéger vos informations financières :")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                VStack(spacing: 20) {
                    SecurityFeatureView(icon: "lock.shield.fill", title: "Sécurité des Données", description: "Vos données sont cryptées et stockées de manière sécurisée.")
                    SecurityFeatureView(icon: "faceid", title: "Authentification Biométrique", description: "Utilisez la reconnaissance faciale ou l'empreinte digitale pour sécuriser l'accès à votre compte.")
                    SecurityFeatureView(icon: "creditcard.fill", title: "Transactions Sécurisées", description: "Toutes les transactions sont sécurisées avec des protocoles de chiffrement avancés.")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                )
                
                Text("Nous respectons également votre vie privée. Consultez notre politique de confidentialité pour en savoir plus sur la collecte et l'utilisation de vos données.")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.gray.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarTitle("Sécurité et Confidentialité", displayMode: .inline)
    }
}

struct SecurityFeatureView: View {
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 50, height: 50)
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.blue)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(.vertical, 10)
    }
}

struct SecurityPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SecurityPrivacyView()
        }
    }
}
