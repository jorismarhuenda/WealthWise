//
//  TaxTrackingView.swift
//  WealthWise
//
//  Created by marhuenda joris on 05/09/2023.
//

import SwiftUI

struct TaxTrackingView: View {
    // Exemple de données pour les paiements d'impôts et les documents fiscaux
    let taxPayments = [
        TaxPayment(name: "Impôt sur le revenu 2022", amount: 4500.00),
        TaxPayment(name: "Taxe foncière 2022", amount: 1200.00),
        // Ajoutez d'autres paiements d'impôts
    ]
    
    let taxDocuments = [
        TaxDocument(name: "Déclaration d'impôt 2021", fileType: "PDF"),
        TaxDocument(name: "Avis d'imposition 2021", fileType: "PDF"),
        // Ajoutez d'autres documents fiscaux
    ]
    
    var body: some View {
        VStack {
            Text("Suivi des Impôts")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            // Liste des paiements d'impôts
            Section(header: Text("Paiements d'Impôts")) {
                if taxPayments.isEmpty {
                    Text("Aucun paiement d'impôt enregistré.")
                } else {
                    List(taxPayments) { payment in
                        TaxPaymentRow(payment: payment)
                    }
                }
            }
            .padding(.vertical, 10)
            
            // Liste des documents fiscaux
            Section(header: Text("Documents Fiscaux")) {
                if taxDocuments.isEmpty {
                    Text("Aucun document fiscal enregistré.")
                } else {
                    List(taxDocuments) { document in
                        TaxDocumentRow(document: document)
                    }
                }
            }
            .padding(.vertical, 10)
        }
        .padding()
        .navigationBarTitle("Suivi des Impôts", displayMode: .inline)
    }
}

struct TaxPayment: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
}

struct TaxDocument: Identifiable {
    let id = UUID()
    let name: String
    let fileType: String
}

struct TaxPaymentRow: View {
    let payment: TaxPayment
    
    var body: some View {
        HStack {
            Text(payment.name)
            Spacer()
            Text("$\(payment.amount, specifier: "%.2f")")
                .foregroundColor(.green)
        }
    }
}

struct TaxDocumentRow: View {
    let document: TaxDocument
    
    var body: some View {
        HStack {
            Text(document.name)
            Spacer()
            Text(document.fileType)
                .foregroundColor(.blue)
        }
    }
}

struct TaxTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TaxTrackingView()
    }
}
