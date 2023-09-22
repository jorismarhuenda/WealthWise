//
//  LoanManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 06/09/2023.
//

import SwiftUI
import Firebase

struct LoanManagementView: View {
    @State private var loans: [Loan] = []
    @State private var newLoanName = ""
    @State private var newLoanAmount = ""
    @State private var newInterestRate = ""
    @State private var newTerm = ""
    
    var body: some View {
        VStack {
            Text("Gestion des Prêts")
                .font(.title)
            
            List {
                ForEach(loans.indices, id: \.self) { index in
                    NavigationLink(destination: LoanDetailEditView(loan: $loans[index])) {
                        LoanRow(loan: loans[index])
                    }
                }
                .onDelete(perform: deleteLoan)
            }
            
            Section(header: Text("Ajouter un Nouveau Prêt")) {
                TextField("Nom du Prêt", text: $newLoanName)
                TextField("Montant du Prêt", text: $newLoanAmount)
                    .keyboardType(.numberPad)
                TextField("Taux d'Intérêt", text: $newInterestRate)
                    .keyboardType(.decimalPad)
                TextField("Durée (mois)", text: $newTerm)
                    .keyboardType(.numberPad)
                
                Button(action: addLoan) {
                    Text("Ajouter")
                }
            }
            .padding()
        }
        .onAppear (perform: fetchLoans)
        
    }
    
    // Fonction pour ajouter un prêt à Firestore
    func addLoan() {
        guard let user = Auth.auth().currentUser else {
            // L'utilisateur n'est pas connecté, gérer cette situation
            return
        }
        
        if let amount = Double(newLoanAmount),
           let interestRate = Double(newInterestRate),
           let term = Int(newTerm) {
            let newLoan = Loan(id: UUID().uuidString, name: newLoanName, amount: amount, interestRate: interestRate, term: term)
            
            // Ajoutez le prêt à Firestore avec l'ID de l'utilisateur
            let db = Firestore.firestore()
            db.collection("loans").document(user.uid).collection("userLoans").addDocument(data: [
                "name": newLoan.name,
                "amount": newLoan.amount,
                "interestRate": newLoan.interestRate,
                "term": newLoan.term
            ]) { error in
                if let error = error {
                    print("Erreur lors de l'ajout du prêt : \(error)")
                } else {
                    // Réinitialisez les champs de saisie
                    newLoanName = ""
                    newLoanAmount = ""
                    newInterestRate = ""
                    newTerm = ""
                    // Rafraîchissez la liste des prêts
                    fetchLoans()
                }
            }
        }
    }
    
    // Fonction pour supprimer un prêt de Firestore
    func deleteLoan(at offsets: IndexSet) {
        guard let user = Auth.auth().currentUser else {
            // L'utilisateur n'est pas connecté, gérer cette situation
            return
        }
        
        let db = Firestore.firestore()
        
        // Supprimez les prêts sélectionnés pour l'utilisateur actuel
        offsets.forEach { index in
            let loan = loans[index]
            db.collection("loans").document(user.uid).collection("userLoans").document(loan.id).delete { error in
                if let error = error {
                    print("Erreur lors de la suppression du prêt : \(error)")
                } else {
                    loans.remove(at: index)
                }
            }
        }
    }
    
    // Fonction pour récupérer les prêts depuis Firestore
    func fetchLoans() {
        guard let user = Auth.auth().currentUser else {
            // L'utilisateur n'est pas connecté, gérer cette situation
            return
        }
        
        let db = Firestore.firestore()
        db.collection("loans").document(user.uid).collection("userLoans").getDocuments { snapshot, error in
            if let error = error {
                print("Erreur lors de la récupération des prêts : \(error)")
                return
            }
            
            if let documents = snapshot?.documents {
                loans = documents.compactMap { document in
                    guard
                        let name = document.data()["name"] as? String,
                        let amount = document.data()["amount"] as? Double,
                        let interestRate = document.data()["interestRate"] as? Double,
                        let term = document.data()["term"] as? Int
                    else {
                        return nil
                    }
                    return Loan(id: document.documentID, name: name, amount: amount, interestRate: interestRate, term: term)
                }
            }
        }
    }
}
    
struct LoanRow: View {
    var loan: Loan
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(loan.name)
                    .font(.headline)
                Text("Montant : \(loan.amount) €")
                Text("Taux d'Intérêt : \(loan.interestRate)%")
                Text("Durée : \(loan.term) mois")
            }
        }
    }
}

struct Loan: Identifiable {
    var id: String
    var name: String
    var amount: Double
    var interestRate: Double
    var term: Int
}

struct LoanManagementView_Previews: PreviewProvider {
    static var previews: some View {
        LoanManagementView()
    }
}
