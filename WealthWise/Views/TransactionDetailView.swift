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
        VStack(alignment: .leading, spacing: 25) {
            Text("Détails de la Transaction")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .padding(.bottom, 20)
            
            VStack(spacing: 15) {
                TransactionDetailRow(label: "Bénéficiaire:", value: transaction.beneficiary)
                
                // Conversion de la date en String formatée
                TransactionDetailRow(label: "Date:", value: formatDate(transaction.date))
                
                TransactionDetailRow(label: "Montant:", value: String(format: "%.2f €", transaction.amount))
                TransactionDetailRow(label: "Catégorie:", value: transaction.category)
                
                if let notes = transaction.notes {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notes:")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text(notes)
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            )
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            )
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarTitle("Détails de la Transaction", displayMode: .inline)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct TransactionDetailRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.blue)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
        }
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
