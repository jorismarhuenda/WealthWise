//
//  SiriIntegrationView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct SiriIntegrationView: View {
   var body: some View {
        VStack(spacing: 20) {
            Text("Intégration de Siri")
                .font(.title)
            
            // Ajoutez ici des éléments pour expliquer comment Siri est intégré dans l'application
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Intégration de Siri")
    }
}

struct SiriIntegrationView_Previews: PreviewProvider {
    static var previews: some View {
        SiriIntegrationView()
    }
}
