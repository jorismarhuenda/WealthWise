//
//  InvestmentAssistanceView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct InvestmentAssistanceView: View {
    var body: some View {
            VStack(spacing: 20) {
                Text("Aide à l'Investissement")
                    .font(.title)
                
                // Ajoutez des éléments pour fournir de l'aide à l'investissement
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Aide à l'Investissement")
    }
}

struct InvestmentAssistanceView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentAssistanceView()
    }
}
