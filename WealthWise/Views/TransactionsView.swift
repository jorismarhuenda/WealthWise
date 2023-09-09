//
//  TransactionsView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI
import Foundation

struct TransactionsView: View {
    @ObservedObject var transactionManager: TransactionManager
    @State private var showAddTransactionView = false

    @EnvironmentObject var userProfileWrapper: UserProfileWrapper // Injectez-le ici

    var body: some View {
        NavigationView {
            VStack (spacing: 20) {
                Text("Transactions")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Button(action: {
                    showAddTransactionView = true
                }) {
                    Text("Ajouter une transaction")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showAddTransactionView) {
                    AddTransactionView(transactionManager: transactionManager, userID: userProfileWrapper.userProfile.id)
                }

                TransactionsListView(transactionManager: transactionManager)
            }
            .navigationBarTitle("Transactions")
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(transactionManager: TransactionManager())
    }
}

struct TransactionsListView: View {
    @ObservedObject var transactionManager: TransactionManager

    
    // Déclarez et initialisez dateFormatter ici
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var body: some View {
        List(transactionManager.transactions) { transaction in
            Text(transaction.description)
            Text("\(transaction.amount, specifier: "%.2f") €")
            Text("\(transaction.date, formatter: dateFormatter)")
        }
    }
}

struct AddTransactionView: View {
    @State private var description = ""
    @State private var amount = ""
    @State private var date = Date()
    
    @ObservedObject var transactionManager: TransactionManager
    var userID: String // L'identifiant de l'utilisateur
    
    var body: some View {
        Form {
            TextField("Description", text: $description)
            TextField("Montant", text: $amount)
                .keyboardType(.decimalPad)
            DatePicker("Date", selection: $date, displayedComponents: .date)
            Button(action: {
                if let amount = Double(amount) {
                    let newTransaction = Transaction(id: UUID().uuidString, description: description, amount: amount, userID: userID, date: date) // Utilisez l'identifiant de l'utilisateur
                    transactionManager.addTransaction(transaction: newTransaction)
                }
            }) {
                Text("Ajouter Transaction")
            }
        }
    }
}
