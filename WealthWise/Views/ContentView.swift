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
                    .foregroundColor(.blue)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                            .shadow(radius: 10)
                    )
                
                Text("Bienvenue sur WealthWise")
                    .font(.title)
                    .foregroundColor(.blue)
                
                NavigationLink(destination: DashboardView()) {
                    Text("Tableau de Bord")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(10)
                }
                
                NavigationLink(destination: SecurityPrivacyView()) {
                    Text("Sécurité et Confidentialité")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(10)
                }
                
                NavigationLink(destination: SiriIntegrationView()) {
                    Text("Intégration de Siri")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(10)
                }
                
                NavigationLink(destination: FinancialEducationView()) {
                    Text("Éducation Financière")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(10)
                }
                
                Button(action: {
                    showingAlertsAndNotifications = true
                }) {
                    Text("Alertes et Notifications")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(10)
                }
                .sheet(isPresented: $showingAlertsAndNotifications) {
                    AlertsAndNotificationsView()
                }
                
                NavigationLink(destination: ProfileConfigurationView()) {
                    Text("Configuration du Profil")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(10)
                }
                
                Spacer()
            }
            .padding()
            .background(
                Color.white
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
