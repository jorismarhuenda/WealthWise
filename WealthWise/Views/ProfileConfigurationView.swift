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
            Form {
                Section(header: Text("Informations de profil")) {
                    TextField("Nom d'utilisateur", text: $profileViewModel.userProfile.username)
                    TextField("Adresse e-mail", text: $profileViewModel.userProfile.email)
                    TextField("Numéro de téléphone", text: $profileViewModel.userProfile.phoneNumber)
                    Picker("Pays", selection: $profileViewModel.userProfile.selectedCountry) {
                        Text("Sélectionner un pays").tag("Sélectionner un pays")
                        Text("États-Unis").tag("États-Unis")
                        Text("Canada").tag("Canada")
                        Text("France").tag("France")
                        // Ajoutez d'autres pays si nécessaire
                    }
                    .pickerStyle(DefaultPickerStyle())
                }

                Section(header: Text("Préférences")) {
                    Toggle("Activer les notifications", isOn: $profileViewModel.userProfile.isNotificationsEnabled)
                }

                Section {
                    Button(action: {
                        // Enregistrez les modifications du profil sur Firebase
                        profileViewModel.saveProfileToFirebase()
                    }) {
                        Text("Enregistrer les modifications")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }

                // Section pour activer ou désactiver l'utilisation de Face ID
                Section {
                    Toggle("Utiliser Face ID", isOn: $authenticationViewModel.useFaceID)
                        .padding()

                    Button(action: {
                        authenticationViewModel.toggleFaceID()
                    }) {
                        Text(authenticationViewModel.useFaceID ? "Désactiver Face ID" : "Activer Face ID")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Configuration du Profil")
            .onAppear {
                // Chargement des données de profil depuis Firebase lors de l'affichage de la vue
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
