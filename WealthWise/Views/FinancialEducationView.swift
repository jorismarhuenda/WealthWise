//
//  FinancialEducationView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct FinancialEducationView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Éducation Financière")
                .font(.title)
            
            // Ajoutez ici des éléments pour fournir des ressources d'éducation financière
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Éducation Financière")
    }
}

struct FinancialEducationView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialEducationView()
    }
}
