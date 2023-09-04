//
//  ContentView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image("logo") // Votre logo ici
                
                Text("Bienvenue sur WealthWise")
                    .font(.title)
                    .foregroundColor(.blue)
                
                NavigationLink(destination: DashboardView()) {
                    Text("Tableau de Bord")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: SecurityPrivacyView()) {
                    Text("Sécurité et Confidentialité")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: SiriIntegrationView()) {
                    Text("Intégration de Siri")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: FinancialEducationView()) {
                    Text("Éducation Financière")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
