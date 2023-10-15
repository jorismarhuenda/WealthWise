//
//  PasswordResetView.swift
//  WealthWise
//
//  Created by marhuenda joris on 15/10/2023.
//

import SwiftUI
import Firebase

struct PasswordResetView: View {
    @State private var email = ""
    @State private var resetError: String?
    @State private var isResetSuccess = false
    
    var body: some View {
        VStack {
            Text("Récupération du Mot de Passe")
                .font(.title)
                .foregroundColor(.blue)
                .padding(.bottom, 20)
            
            TextField("Adresse e-mail", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            if let error = resetError {
                Text(error)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
            
            Button(action: {
                resetError = nil
                
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        // Gérer l'erreur de réinitialisation du mot de passe
                        resetError = error.localizedDescription
                        print("Erreur de réinitialisation du mot de passe : \(error.localizedDescription)")
                    } else {
                        // La réinitialisation du mot de passe a réussi
                        isResetSuccess = true
                    }
                }
            }) {
                Text("Réinitialiser le Mot de Passe")
                    .frame(width: 250, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(15)
            }
            .alert(isPresented: $isResetSuccess) {
                Alert(
                    title: Text("Réinitialisation Réussie"),
                    message: Text("Un e-mail de réinitialisation du mot de passe a été envoyé à \(email)."),
                    dismissButton: .default(Text("OK")) {
                        // Retour à l'écran de connexion
                    }
                )
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView()
    }
}
