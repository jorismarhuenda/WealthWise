//
//  ContentView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI
import CoreData
import Firebase

struct ContentView: View {
    @State private var showingAlertsAndNotifications = false
    @EnvironmentObject var userProfileWrapper: UserProfileWrapper

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
                            .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
                    )

                Text("Bienvenue sur WealthWise! 😊")
                    .font(.title)
                    .foregroundColor(.blue)

                NavigationLink(destination: DashboardView()) {
                    Text("Explorez le Tableau de Bord 📊")
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.9)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .padding(15)
                }

                NavigationLink(destination: SecurityPrivacyView()) {
                    Text("Découvrez la Sécurité et Confidentialité 🔐")
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.9)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .padding(15)
                }

                NavigationLink(destination: SiriIntegrationView()) {
                    Text("Explorez l'Intégration de Siri 🗣️")
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.9)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .padding(15)
                }

                NavigationLink(destination: FinancialEducationView()) {
                    Text("Enrichissez-vous avec l'Éducation Financière 📚")
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.9)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .padding(15)
                }

                Button(action: {
                    showingAlertsAndNotifications = true
                }) {
                    Text("Recevez des Alertes et Notifications 🚨")
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.9)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .padding(15)
                }
                .sheet(isPresented: $showingAlertsAndNotifications) {
                    AlertsAndNotificationsView()
                }

                NavigationLink(destination: ProfileConfigurationView()) {
                    Text("Configurez votre Profil 🛠️")
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.9)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .padding(15)
                }

                Spacer()
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
