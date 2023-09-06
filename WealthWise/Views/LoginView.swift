//
//  LoginView.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    @Binding var isLoggedIn: Bool
    @State private var authenticationError: String? // Variable pour stocker les messages d'erreur
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.bottom, 20)
            
            Text(isRegistering ? "Inscription" : "Connexion")
                .font(.title)
                .foregroundColor(.blue)
            
            TextField("Adresse e-mail", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            SecureField("Mot de passe", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            if let error = authenticationError {
                Text(error)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                authenticationError = nil // Réinitialisez l'erreur à nil
                
                if isRegistering {
                    // Inscription avec Firebase
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            // Gérez l'erreur d'inscription ici
                            authenticationError = error.localizedDescription
                            print("Erreur d'inscription : \(error.localizedDescription)")
                        } else {
                            // L'inscription a réussi, vous pouvez rediriger l'utilisateur vers le tableau de bord ou une autre vue principale
                            isLoggedIn = true
                        }
                    }
                } else {
                    // Connexion avec Firebase
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            // Gérez l'erreur de connexion ici
                            authenticationError = error.localizedDescription
                            print("Erreur de connexion : \(error.localizedDescription)")
                        } else {
                            // La connexion a réussi, vous pouvez rediriger l'utilisateur vers le tableau de bord ou une autre vue principale
                            isLoggedIn = true
                        }
                    }
                }
            }) {
                Text(isRegistering ? "S'inscrire" : "Se connecter")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                isRegistering.toggle()
            }) {
                Text(isRegistering ? "Déjà inscrit ? Connectez-vous" : "Nouvel utilisateur ? Inscrivez-vous")
                    .foregroundColor(.blue)
                    .padding(.top, 20)
            }
            
            Button(action: {
                // Code pour passer en mode visiteur et accéder à ContentView
                isLoggedIn = true
            }) {
                Text("Visiteur")
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var isLoggedIn = false
    
    static var previews: some View {
        LoginView(isLoggedIn: $isLoggedIn)
    }
}
