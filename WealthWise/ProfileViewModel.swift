//
//  ProfileViewModel.swift
//  WealthWise
//
//  Created by marhuenda joris on 06/09/2023.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var userProfile = UserProfile(email: "")

    init() {
        if let user = Auth.auth().currentUser {
            // Utilisateur connecté
            userProfile.email = user.email ?? ""
        }
        loadProfileFromFirebase()
    }

    func saveProfileToFirebase() {
            let db = Firestore.firestore()
            let userEmail = userProfile.email // Utilisez l'adresse e-mail de l'utilisateur connecté

            db.collection("utilisateurs").document(userEmail).setData([
                "username": userProfile.username,
                "phoneNumber": userProfile.phoneNumber,
                "selectedCountry": userProfile.selectedCountry,
                "isNotificationsEnabled": userProfile.isNotificationsEnabled
            ]) { error in
                if let error = error {
                    print("Erreur lors de l'enregistrement du profil sur Firebase : \(error)")
                } else {
                    print("Profil enregistré avec succès sur Firebase.")
                }
            }
        }

    func loadProfileFromFirebase() {
            let db = Firestore.firestore()
            let userEmail = userProfile.email // Utilisez l'adresse e-mail de l'utilisateur connecté

            db.collection("utilisateurs").document(userEmail).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    self.userProfile.username = data?["username"] as? String ?? ""
                    self.userProfile.phoneNumber = data?["phoneNumber"] as? String ?? ""
                    self.userProfile.selectedCountry = data?["selectedCountry"] as? String ?? "Sélectionner un pays"
                    self.userProfile.isNotificationsEnabled = data?["isNotificationsEnabled"] as? Bool ?? true
                } else {
                    print("Le document de profil n'existe pas sur Firebase.")
                }
            }
        }
}
