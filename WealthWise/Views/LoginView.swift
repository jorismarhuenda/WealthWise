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
    @State private var isPasswordResetShowing = false

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding(.bottom, 20)
            
            Text(isRegistering ? "Inscription" : "Connexion")
                .font(.title)
                .foregroundColor(.blue)
            
            VStack(spacing: 10) {
                TextField("Adresse e-mail", text: $email)
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                
                SecureField("Mot de passe", text: $password)
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
            }
            .padding(.horizontal, 20)
            
            if let error = authenticationError {
                Text(error)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
            
            HStack {
                Button(action: {
                    authenticationError = nil // Réinitialisez l'erreur à nil
                    
                    if isRegistering {
                        // Inscription avec Firebase
                        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            handleAuthenticationResult(authResult: authResult, error: error)
                        }
                    } else {
                        // Connexion avec Firebase
                        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                            handleAuthenticationResult(authResult: authResult, error: error)
                        }
                    }
                }) {
                    Text(isRegistering ? "S'inscrire" : "Se connecter")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(15)
                }
                
                if !isRegistering {
                    Button(action: {
                        // Ajoutez ici la logique pour la récupération du mot de passe
                        isPasswordResetShowing.toggle()
                    }) {
                        Text("Mot de passe oublié?")
                            .foregroundColor(.blue)
                            .padding(.top, 20)
                    }
                    .sheet(isPresented: $isPasswordResetShowing) {
                        // Ajoutez ici la vue de récupération du mot de passe
                        PasswordResetView()
                    }
                }
            }
            
            Button(action: {
                isRegistering.toggle()
            }) {
                Text(isRegistering ? "Déjà inscrit ? Connectez-vous" : "Nouvel utilisateur ? Inscrivez-vous")
                    .foregroundColor(.blue)
                    .padding(.top, 20)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
    
    private func handleAuthenticationResult(authResult: AuthDataResult?, error: Error?) {
        if let error = error {
            // Gérez l'erreur d'authentification ici
            authenticationError = error.localizedDescription
            print("Erreur d'authentification : \(error.localizedDescription)")
        } else {
            // L'authentification a réussi, vous pouvez rediriger l'utilisateur vers le tableau de bord ou une autre vue principale
            isLoggedIn = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var isLoggedIn = false
    
    static var previews: some View {
        LoginView(isLoggedIn: $isLoggedIn)
    }
}
