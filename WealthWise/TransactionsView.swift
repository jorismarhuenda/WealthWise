//
//  TransactionsView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct TransactionsView: View {
    var body: some View {
        VStack {
            Text("Transactions")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Ajoutez ici des éléments pour afficher et gérer les transactions
        }
        .navigationBarTitle("Transactions")
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
