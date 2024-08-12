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
            VStack(spacing: 25) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .padding(20)
                    .background(
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .blur(radius: 10)
                    )

                Text("Bienvenue sur WealthWise! 😊")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.blue)

                VStack(spacing: 15) {
                    NavigationLink(destination: DashboardView()) {
                        Text("Explorez le Tableau de Bord 📊")
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue.opacity(0.85))
                            )
                            .foregroundColor(.white)
                    }

                    NavigationLink(destination: SecurityPrivacyView()) {
                        Text("Découvrez la Sécurité et Confidentialité 🔐")
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue.opacity(0.85))
                            )
                            .foregroundColor(.white)
                    }

                    NavigationLink(destination: SiriIntegrationView()) {
                        Text("Explorez l'Intégration de Siri 🗣️")
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue.opacity(0.85))
                            )
                            .foregroundColor(.white)
                    }

                    NavigationLink(destination: FinancialEducationView()) {
                        Text("Enrichissez-vous avec l'Éducation Financière 📚")
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue.opacity(0.85))
                            )
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        showingAlertsAndNotifications = true
                    }) {
                        Text("Recevez des Alertes et Notifications 🚨")
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue.opacity(0.85))
                            )
                            .foregroundColor(.white)
                    }
                    .sheet(isPresented: $showingAlertsAndNotifications) {
                        AlertsAndNotificationsView()
                    }

                    NavigationLink(destination: ProfileConfigurationView()) {
                        Text("Configurez votre Profil 🛠️")
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue.opacity(0.85))
                            )
                            .foregroundColor(.white)
                    }
                }
                .padding([.leading, .trailing], 10)

                Spacer()
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.05)]), startPoint: .top, endPoint: .bottom)
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
