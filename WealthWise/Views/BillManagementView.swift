//
//  BillManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 05/09/2023.
//

import SwiftUI

struct BillManagementView: View {
    @State private var newBillName = ""
    @State private var newBillAmount = ""
    @Binding var bills: [Bill]
    
    init(bills: Binding<[Bill]>) {
            _bills = bills // Initialisez la liaison
        }
    
    var body: some View {
        VStack {
            Text("Gestion des Factures")
                .font(.title)
                .padding()
            
            List {
                ForEach(bills, id: \.id) { bill in
                    VStack(alignment: .leading) {
                        Text(bill.name)
                            .font(.headline)
                        Text("Montant : \(bill.amount) €")
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: deleteBill)
            }
            
            Divider()
            
            HStack {
                TextField("Nom de la facture", text: $newBillName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Montant (€)", text: $newBillAmount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: addBill) {
                    Text("Ajouter")
                }
            }
            .padding()
        }
    }
    
    // Fonction pour ajouter une nouvelle facture
    func addBill() {
        guard let amount = Double(newBillAmount), !newBillName.isEmpty else {
            return
        }
        
        let newBill = Bill(name: newBillName, amount: amount)
        bills.append(newBill)
        
        // Réinitialiser les champs de saisie
        newBillName = ""
        newBillAmount = ""
    }
    
    // Fonction pour supprimer une facture
    func deleteBill(at offsets: IndexSet) {
        bills.remove(atOffsets: offsets)
    }
}

struct BillManagementView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleBills: [Bill] = [
            Bill(name: "Facture 1", amount: 100.0),
            Bill(name: "Facture 2", amount: 200.0)
        ]
        
        return BillManagementView(bills: .constant(sampleBills))
    }
}

struct Bill: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
}

