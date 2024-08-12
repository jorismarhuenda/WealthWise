//
//  ProfileConfigurationView.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI
import Firebase
import LocalAuthentication

struct ProfileConfigurationView: View {
    @ObservedObject private var profileViewModel = ProfileViewModel()
    @ObservedObject private var authenticationViewModel = AuthenticationViewModel()
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Configuration du Profil")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.blue)
                    .padding(.top, 20)

                Form {
                    Section(header: Text("Informations de profil").font(.headline).foregroundColor(.blue)) {
                        TextField("Nom d'utilisateur", text: $profileViewModel.userProfile.username)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)

                        TextField("Adresse e-mail", text: $profileViewModel.userProfile.email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)

                        TextField("Numéro de téléphone", text: $profileViewModel.userProfile.phoneNumber)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)

                        Picker("Pays", selection: $profileViewModel.userProfile.selectedCountry) {
                            Text("Sélectionner un pays").tag("Sélectionner un pays")
                            Text("États-Unis").tag("États-Unis")
                            Text("Canada").tag("Canada")
                            Text("France").tag("France")
                        }
                        .pickerStyle(DefaultPickerStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                    .listRowBackground(Color.clear)

                    Section(header: Text("Préférences").font(.headline).foregroundColor(.blue)) {
                        Toggle("Activer les notifications", isOn: $profileViewModel.userProfile.isNotificationsEnabled)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                    .listRowBackground(Color.clear)

                    Section {
                        Button(action: {
                            profileViewModel.saveProfileToFirebase()
                            showAlert = true
                        }) {
                            Text("Enregistrer les modifications")
                                .font(.headline)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                                )
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
                    .listRowBackground(Color.clear)

                    Section {
                        Toggle("Utiliser Face ID", isOn: $authenticationViewModel.useFaceID)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)

                        Button(action: {
                            authenticationViewModel.toggleFaceID()
                        }) {
                            Text(authenticationViewModel.useFaceID ? "Désactiver Face ID" : "Activer Face ID")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                                )
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 10)
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(GroupedListStyle())
                .padding(.horizontal)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.05), Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .onAppear {
                profileViewModel.loadProfileFromFirebase()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Sauvegarde réussie"),
                    message: Text("Les modifications du profil ont été enregistrées avec succès sur Firebase."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct ProfileConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileConfigurationView()
    }
}
