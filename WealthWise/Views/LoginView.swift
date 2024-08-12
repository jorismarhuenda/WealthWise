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
    @State private var confirmPassword = ""
    @State private var isRegistering = false
    @Binding var isLoggedIn: Bool
    @State private var authenticationError: String? // Variable pour stocker les messages d'erreur
    @State private var isPasswordResetShowing = false

    // Variables pour les critères du mot de passe
    @State private var isPasswordLengthValid = false
    @State private var isPasswordUppercaseValid = false
    @State private var isPasswordDigitValid = false
    @State private var isPasswordSpecialCharValid = false

    var body: some View {
        VStack(spacing: 20) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding(.bottom, 20)

            Text(isRegistering ? "Inscription" : "Connexion")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.blue)

            VStack(spacing: 15) {
                TextField("Adresse e-mail", text: $email)
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2))

                SecureField("Mot de passe", text: $password)
                    .onChange(of: password, perform: { value in
                        updatePasswordCriteria()
                    })
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2))

                if isRegistering {
                    SecureField("Confirmer le mot de passe", text: $confirmPassword)
                        .padding(15)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2))

                    VStack(alignment: .leading, spacing: 5) {
                        PasswordCriteriaView(label: "Minimum 8 caractères", isValid: isPasswordLengthValid)
                        PasswordCriteriaView(label: "Au moins une majuscule", isValid: isPasswordUppercaseValid)
                        PasswordCriteriaView(label: "Au moins un chiffre", isValid: isPasswordDigitValid)
                        PasswordCriteriaView(label: "Au moins un caractère spécial", isValid: isPasswordSpecialCharValid)
                    }
                    .padding(.leading, 20)
                }
            }
            .padding(.horizontal, 20)

            if let error = authenticationError {
                Text(error)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }

            HStack(spacing: 15) {
                Button(action: {
                    authenticationError = nil

                    if isRegistering {
                        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            handleAuthenticationResult(authResult: authResult, error: error)
                        }
                    } else {
                        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                            handleAuthenticationResult(authResult: authResult, error: error)
                        }
                    }
                }) {
                    Text(isRegistering ? "S'inscrire" : "Se connecter")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }

                if !isRegistering {
                    Button(action: {
                        isPasswordResetShowing.toggle()
                    }) {
                        Text("Mot de passe oublié?")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $isPasswordResetShowing) {
                        PasswordResetView()
                    }
                }
            }
            .padding(.horizontal, 20)

            Button(action: {
                isRegistering.toggle()
            }) {
                Text(isRegistering ? "Déjà inscrit ? Connectez-vous" : "Nouvel utilisateur ? Inscrivez-vous")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(.top, 20)
            }

            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
        .cornerRadius(20)
        .shadow(radius: 5)
    }

    private func handleAuthenticationResult(authResult: AuthDataResult?, error: Error?) {
        if let error = error {
            authenticationError = error.localizedDescription
            print("Erreur d'authentification : \(error.localizedDescription)")
        } else {
            isLoggedIn = true
        }
    }

    private func updatePasswordCriteria() {
        isPasswordLengthValid = password.count >= 8
        isPasswordUppercaseValid = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        isPasswordDigitValid = password.rangeOfCharacter(from: .decimalDigits) != nil
        isPasswordSpecialCharValid = password.rangeOfCharacter(from: .punctuationCharacters) != nil
    }
}

struct PasswordCriteriaView: View {
    let label: String
    let isValid: Bool

    var body: some View {
        HStack {
            Image(systemName: isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(isValid ? .green : .red)
            Text(label)
                .foregroundColor(isValid ? .green : .red)
                .font(.subheadline)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var isLoggedIn = false

    static var previews: some View {
        LoginView(isLoggedIn: $isLoggedIn)
    }
}
