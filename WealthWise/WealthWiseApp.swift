//
//  WealthWiseApp.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

@main
struct WealthWiseApp: App {
    @State private var isLoggedIn = false // Vous pouvez utiliser cette variable pour gérer l'état de connexion
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

