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
            VStack(spacing: 25) {
                Button(action: {
                    showAddTransactionView = true
                }) {
                    Text("Ajouter une transaction")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                }
                .sheet(isPresented: $showAddTransactionView) {
                    AddTransactionView(transactionManager: transactionManager, userID: userProfileWrapper.userProfile.id)
                }

                TransactionListView(transactionManager: transactionManager)
                    .padding(.horizontal)
            }
            .padding(.top, 20)
            .navigationBarTitle("Transactions", displayMode: .inline)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.gray.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
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
        NavigationView {
            Form {
                Section(header: Text("Nouvelle Transaction")
                            .font(.headline)
                            .foregroundColor(.blue)) {
                    TextField("Description", text: $description)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    
                    TextField("Montant", text: $amount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                }

                Section {
                    Button(action: {
                        if let amount = Double(amount) {
                            let newTransaction = Transaction(id: UUID().uuidString, description: description, amount: amount, userID: userID, date: date)
                            transactionManager.addTransaction(transaction: newTransaction)
                        }
                    }) {
                        Text("Ajouter Transaction")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Ajouter Transaction", displayMode: .inline)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.05), Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}
