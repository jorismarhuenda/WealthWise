//
//  LoanManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 06/09/2023.
//

import SwiftUI

struct LoanManagementView: View {
    @State private var loans = [
        Loan(name: "Prêt Auto", amount: 20000, interestRate: 5.5, term: 48),
        Loan(name: "Prêt Étudiant", amount: 15000, interestRate: 4.0, term: 60),
    ]
    
    @State private var newLoanName = ""
    @State private var newLoanAmount = ""
    @State private var newInterestRate = ""
    @State private var newTerm = ""
    
    var body: some View {
        VStack {
            Text("Gestion des Prêts")
                .font(.title)
            
            List {
                ForEach(loans) { loan in
                    NavigationLink(destination: LoanDetailEditView(loan: $loans[getIndex(for: loan)])) {
                        LoanRow(loan: loan)
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
    }
    
    // Fonction pour ajouter un prêt à la liste
    func addLoan() {
        if let amount = Double(newLoanAmount),
           let interestRate = Double(newInterestRate),
           let term = Int(newTerm) {
            let newLoan = Loan(name: newLoanName, amount: amount, interestRate: interestRate, term: term)
            loans.append(newLoan)
            newLoanName = ""
            newLoanAmount = ""
            newInterestRate = ""
            newTerm = ""
        }
    }
    
    // Fonction pour supprimer un prêt de la liste
    func deleteLoan(at offsets: IndexSet) {
        loans.remove(atOffsets: offsets)
    }
    
    // Fonction pour obtenir l'index d'un prêt dans la liste
    func getIndex(for loan: Loan) -> Int {
        if let index = loans.firstIndex(where: { $0.id == loan.id }) {
            return index
        }
        return 0
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
    var id = UUID()
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
