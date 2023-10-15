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

    @EnvironmentObject var userProfileWrapper: UserProfileWrapper

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button(action: {
                    showAddTransactionView = true
                }) {
                    Text("Ajouter une transaction")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(10)
                }
                .sheet(isPresented: $showAddTransactionView) {
                    AddTransactionView(transactionManager: transactionManager, userID: userProfileWrapper.userProfile.id)
                }

                TransactionListView(transactionManager: transactionManager)
            }
            .padding()
            .navigationBarTitle("Transactions")
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(transactionManager: TransactionManager())
    }
}

struct AddTransactionView: View {
    @State private var description = ""
    @State private var amount = ""
    @State private var date = Date()

    @ObservedObject var transactionManager: TransactionManager
    var userID: String

    var body: some View {
        Form {
            Section(header: Text("Nouvelle Transaction")) {
                TextField("Description", text: $description)
                TextField("Montant", text: $amount)
                    .keyboardType(.decimalPad)
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }

            Section {
                Button(action: {
                    if let amount = Double(amount) {
                        let newTransaction = Transaction(id: UUID().uuidString, description: description, amount: amount, userID: userID, date: date)
                        transactionManager.addTransaction(transaction: newTransaction)
                    }
                }) {
                    Text("Ajouter Transaction")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                                .shadow(radius: 5)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(10)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Ajouter Transaction", displayMode: .inline)
    }
}
