//
//  DebtManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI

struct DebtManagementView: View {
    @State private var debts = [Debt]()
    @State private var isAddingDebt = false
    @State private var newDebtName = ""
    @State private var newDebtAmount = ""
    
    var body: some View {
            VStack {
                List {
                    ForEach(debts, id: \.id) { debt in
                        NavigationLink(destination: DebtDetailView(debt: debt)) {
                            Text(debt.name)
                        }
                    }
                }
                .navigationBarTitle("Gestion de Dettes")
                .navigationBarItems(trailing: Button(action: {
                    isAddingDebt = true
                }) {
                    Image(systemName: "plus")
                })
            }
            .sheet(isPresented: $isAddingDebt) {
                AddDebtView(debts: $debts, isAddingDebt: $isAddingDebt, newDebtName: $newDebtName, newDebtAmount: $newDebtAmount)
            }
        }
    }

struct Debt: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
}

struct DebtDetailView: View {
    let debt: Debt
    
    var body: some View {
        Text("Nom de la dette : \(debt.name)")
        Text("Montant de la dette : \(debt.amount)")
        // Ajoutez d'autres détails de la dette si nécessaire
    }
}

struct AddDebtView: View {
    @Binding var debts: [Debt]
    @Binding var isAddingDebt: Bool
    @Binding var newDebtName: String
    @Binding var newDebtAmount: String
    
    var body: some View {
            Form {
                Section(header: Text("Nouvelle Dette")) {
                    TextField("Nom de la dette", text: $newDebtName)
                    TextField("Montant de la dette", text: $newDebtAmount)
                        .keyboardType(.numberPad)
                }
                
                Button(action: {
                    if let amount = Double(newDebtAmount) {
                        let newDebt = Debt(name: newDebtName, amount: amount)
                        debts.append(newDebt)
                    }
                    isAddingDebt = false
                }) {
                    Text("Ajouter Dette")
                }
            }
            .navigationBarTitle("Ajouter Dette")
        }
    }

