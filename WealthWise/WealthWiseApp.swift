//
//  WealthWiseApp.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI
import Firebase

@main
struct WealthWiseApp: App {
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    @StateObject private var userProfileWrapper = UserProfileWrapper() // Injectez UserProfileWrapper ici

    init() {
        FirebaseApp.configure()
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = false
        Firestore.firestore().settings = settings
    }

    var body: some Scene {
        WindowGroup {
            if authenticationViewModel.isLoggedIn {
                ContentView()
                    .environmentObject(authenticationViewModel)
                    .environmentObject(userProfileWrapper) // Injectez UserProfileWrapper ici
            } else {
                LoginView(isLoggedIn: $authenticationViewModel.isLoggedIn)
            }
        }
    }
}
