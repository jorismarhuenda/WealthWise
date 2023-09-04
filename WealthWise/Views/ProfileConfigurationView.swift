//
//  ProfileConfigurationView.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI

struct ProfileConfigurationView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var selectedCountry = "Sélectionner un pays"
    @State private var isNotificationsEnabled = true

    var body: some View {
        Form {
            Section(header: Text("Informations de profil")) {
                TextField("Nom d'utilisateur", text: $username)
                TextField("Adresse e-mail", text: $email)
                TextField("Numéro de téléphone", text: $phoneNumber)
                Picker("Pays", selection: $selectedCountry) {
                    Text("Sélectionner un pays").tag("Sélectionner un pays")
                    Text("États-Unis").tag("États-Unis")
                    Text("Canada").tag("Canada")
                    Text("France").tag("France")
                    // Ajoutez d'autres pays si nécessaire
                }
                .pickerStyle(DefaultPickerStyle())
            }

            Section(header: Text("Préférences")) {
                Toggle("Activer les notifications", isOn: $isNotificationsEnabled)
            }

            Section {
                Button(action: {
                    // Ajoutez ici la logique pour enregistrer les modifications du profil
                    // Vous pouvez également gérer la sauvegarde des données dans un modèle de profil
                }) {
                    Text("Enregistrer les modifications")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationBarTitle("Configuration du Profil")
    }
}

struct ProfileConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileConfigurationView()
    }
}
