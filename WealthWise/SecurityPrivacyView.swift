//
//  SecurityPrivacyView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct SecurityPrivacyView: View {
   var body: some View {
        VStack(spacing: 20) {
            Text("Sécurité et Confidentialité")
                .font(.title)
            
            // Ajoutez ici des éléments pour expliquer les mesures de sécurité et de confidentialité de l'application
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Sécurité et Confidentialité")
    }
}

struct SecurityPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityPrivacyView()
    }
}
