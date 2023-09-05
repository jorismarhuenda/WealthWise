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
                
                NavigationLink(destination: RiskAnalysisView()) {
                                    Text("Analyse de Risque")
                                        .frame(width: 200, height: 50)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
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
