//
//  AuthenticationViewModel.swift
//  WealthWise
//
//  Created by marhuenda joris on 06/09/2023.
//

import Foundation
import Firebase

class AuthenticationViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var error: String? // Variable pour stocker les messages d'erreur
    
    enum AuthMethod {
        case email, username, phoneNumber
    }
    
    func signIn(with authMethod: AuthMethod, identifier: String, password: String) {
        // Réinitialisez les erreurs à nil
        self.error = nil
        
        switch authMethod {
        case .email:
            Auth.auth().signIn(withEmail: identifier, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    // Gérer l'erreur de connexion
                    self.error = error.localizedDescription
                    print("Erreur de connexion : \(error.localizedDescription)")
                } else {
                    // La connexion a réussi, mettez à jour l'état de connexion
                    self.isLoggedIn = true
                }
            }
            
        case .username:
            // Code pour la connexion par nom d'utilisateur
            // Vérifiez si le nom d'utilisateur et le mot de passe sont corrects
            let isUsernameValid = true // Remplacez par votre logique de validation
            let isPasswordValid = true // Remplacez par votre logique de validation
            
            if isUsernameValid && isPasswordValid {
                // La connexion par nom d'utilisateur a réussi, mettez à jour l'état de connexion
                self.isLoggedIn = true
            } else {
                // Gérez l'erreur si la connexion par nom d'utilisateur échoue
                self.error = "Nom d'utilisateur ou mot de passe incorrect."
            }
            
        case .phoneNumber:
            // Code pour la connexion par numéro de téléphone
            // Vérifiez si le numéro de téléphone et le mot de passe sont corrects
            let isPhoneNumberValid = true // Remplacez par votre logique de validation
            let isPasswordValid = true // Remplacez par votre logique de validation
            
            if isPhoneNumberValid && isPasswordValid {
                // La connexion par numéro de téléphone a réussi, mettez à jour l'état de connexion
                self.isLoggedIn = true
            } else {
                // Gérez l'erreur si la connexion par numéro de téléphone échoue
                self.error = "Numéro de téléphone ou mot de passe incorrect."
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch let signOutError as NSError {
            print("Erreur de déconnexion : \(signOutError.localizedDescription)")
        }
    }
}
