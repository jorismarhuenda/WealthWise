//
//  LoanDetailEditView.swift
//  WealthWise
//
//  Created by marhuenda joris on 06/09/2023.
//

import SwiftUI
import Firebase

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
    
    func saveLoan() {
        // Assurez-vous que l'utilisateur est connecté
        guard let user = Auth.auth().currentUser else {
            // L'utilisateur n'est pas connecté, gérer cette situation (par exemple, afficher une alerte)
            // Vous pouvez afficher une alerte pour informer l'utilisateur qu'il doit se connecter
            // avant de modifier un prêt, ou effectuer d'autres actions appropriées.
            return
        }
        
        // Mettez à jour les détails du prêt dans Firestore
        let db = Firestore.firestore()
        db.collection("loans").document(user.uid).collection("userLoans").document(loan.id).updateData([
            "name": loan.name,
            "amount": loan.amount,
            "interestRate": loan.interestRate,
            "term": loan.term
        ]) { error in
            if let error = error {
                print("Erreur lors de la mise à jour du prêt : \(error)")
            } else {
                // Les modifications ont été enregistrées avec succès
                print("Les modifications du prêt ont été enregistrées avec succès.")
            }
        }
    }

}

struct LoanDetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        LoanDetailEditView(loan: .constant(Loan(id: UUID().uuidString, name: "Prêt Auto", amount: 20000, interestRate: 5.5, term: 48)))
    }
}
