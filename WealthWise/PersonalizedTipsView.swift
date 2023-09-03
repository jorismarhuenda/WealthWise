//
//  PersonalizedTipsView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct PersonalizedTipsView: View {
  var body: some View {
        VStack(spacing: 20) {
            Text("Conseils Personnalisés")
                .font(.title)
            
            // Ajoutez ici des éléments pour fournir des conseils financiers personnalisés
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Conseils Personnalisés")
    }
}

struct PersonalizedTipsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizedTipsView()
    }
}
