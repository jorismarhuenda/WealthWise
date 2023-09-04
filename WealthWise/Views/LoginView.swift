//
//  LoginView.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isRegistering = false
    @Binding var isLoggedIn: Bool // État lié pour gérer la connexion
    
    var body: some View {
        VStack {
            Image("logo") // Votre logo ici
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.bottom, 20)
            
            Text(isRegistering ? "Inscription" : "Connexion")
                .font(.title)
                .foregroundColor(.blue)
            
            TextField("Nom d'utilisateur", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            SecureField("Mot de passe", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            Button(action: {
                // Code pour gérer la connexion ou l'inscription ici
                // Vous pouvez vérifier les valeurs de 'username' et 'password' et authentifier l'utilisateur
                
                if isRegistering {
                    // Effectuez le processus d'inscription
                } else {
                    // Effectuez le processus de connexion
                    isLoggedIn = true
                }
                
                // Une fois l'authentification réussie, vous pouvez rediriger l'utilisateur vers le tableau de bord ou une autre vue principale
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
                isLoggedIn = true // Mettez à jour l'état de connexion pour passer en mode visiteur
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
    @State static var isLoggedIn = false // Créez une variable d'état lié
    
    static var previews: some View {
        LoginView(isLoggedIn: $isLoggedIn) // Fournissez le Binding dans la prévisualisation
    }
}
