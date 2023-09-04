//
//  TransactionsView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct TransactionsView: View {
    var body: some View {
        VStack (spacing: 20) {
            Text("Transactions")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            NavigationLink(destination: TransactionDetailView(transaction: TransactionDetail(id: UUID(),
                                                                                             beneficiary: "",
                                                                                             date: Date(),
                                                                                             amount: 150.0,
                                                                                             category: "",
                                                                                             notes: ""))) {
                Text("Détails de la Transaction")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationBarTitle("Transactions")
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
