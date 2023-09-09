//
//  TransactionDetailView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI
import Foundation

struct TransactionDetailView: View {
    var transaction: TransactionDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Détails de la Transaction")
                .font(.title)
            
            HStack {
                Text("Bénéficiaire:")
                    .font(.headline)
                Spacer()
                Text(transaction.beneficiary)
            }
            
            HStack {
                Text("Date:")
                    .font(.headline)
                Spacer()
                Text(transaction.date, style: .date)
            }
            
            HStack {
                Text("Montant:")
                    .font(.headline)
                Spacer()
                Text(String(format: "%.2f €", transaction.amount))
            }
            
            HStack {
                Text("Catégorie:")
                    .font(.headline)
                Spacer()
                Text(transaction.category)
            }
            
            if let notes = transaction.notes {
                Text("Notes:")
                    .font(.headline)
                Text(notes)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Détails de la Transaction")
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let transaction = TransactionDetail(id: UUID(),
                                            beneficiary: "John Doe",
                                            date: Date(),
                                            amount: 150.0,
                                            category: "Alimentation",
                                            notes: "Déjeuner au restaurant")
        
        return TransactionDetailView(transaction: transaction)
    }
}

