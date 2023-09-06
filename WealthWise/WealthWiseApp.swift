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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if authenticationViewModel.isLoggedIn {
                ContentView()
                    .environmentObject(authenticationViewModel)
            } else {
                LoginView(isLoggedIn: $authenticationViewModel.isLoggedIn)
            }
        }
    }
}
