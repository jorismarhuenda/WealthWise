//
//  LoanDetailEditView.swift
//  WealthWise
//
//  Created by marhuenda joris on 06/09/2023.
//

import SwiftUI

struct LoanDetailEditView: View {
    @Binding var loan: Loan
    
    var body: some View {
        Form {
            Section(header: Text("Détails du Prêt")) {
                TextField("Nom du Prêt", text: $loan.name)
                TextField("Montant du Prêt", value: $loan.amount, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                TextField("Taux d'Intérêt", value: $loan.interestRate, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                TextField("Durée (mois)", value: $loan.term, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
            }
            
            Section {
                Button(action: saveLoan) {
                    Text("Enregistrer les Modifications")
                }
                .disabled(loan.name.isEmpty || loan.amount <= 0 || loan.interestRate <= 0 || loan.term <= 0)
            }
        }
        .navigationTitle("Modifier le Prêt")
    }
    
    // Fonction pour enregistrer les modifications du prêt
    func saveLoan() {
        // Vous pouvez ajouter ici la logique pour sauvegarder les modifications du prêt (par exemple, dans un modèle de données ou une base de données).
        // Pour l'exemple, nous imprimons simplement les détails du prêt.
        print("Modification du prêt :")
        print("Nom : \(loan.name)")
        print("Montant : \(loan.amount) €")
        print("Taux d'Intérêt : \(loan.interestRate)%")
        print("Durée : \(loan.term) mois")
    }
}

struct LoanDetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        LoanDetailEditView(loan: .constant(Loan(name: "Prêt Auto", amount: 20000, interestRate: 5.5, term: 48)))
    }
}
