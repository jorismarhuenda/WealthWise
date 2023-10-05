//
//  BillManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 05/09/2023.
//

import SwiftUI
import Firebase

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
        .onAppear(perform: loadBills) // Chargez les factures au démarrage
    }
    
    // Fonction pour charger les factures depuis Firebase
    func loadBills() {
        guard let user = Auth.auth().currentUser else {
            return // L'utilisateur n'est pas connecté, gestion de l'erreur
        }
        
        let db = Firestore.firestore()
        db.collection("bills")
            .whereField("userID", isEqualTo: user.uid) // Filtrer par ID utilisateur
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Erreur lors du chargement des factures : \(error)")
                } else if let documents = snapshot?.documents {
                    bills = documents.compactMap { document in
                        if let data = document.data() as? [String: Any],
                           let name = data["name"] as? String,
                           let amount = data["amount"] as? Double {
                            return Bill(name: name, amount: amount, userID: user.uid)
                        }
                        return nil
                    }
                }
            }
    }
    
    // Fonction pour ajouter une nouvelle facture
    func addBill() {
        guard let amount = Double(newBillAmount), !newBillName.isEmpty else {
            return
        }
        
        guard let user = Auth.auth().currentUser else {
            return // L'utilisateur n'est pas connecté, gestion de l'erreur
        }
        
        let newBill = Bill(name: newBillName, amount: amount, userID: user.uid)
        
        // Enregistrez la facture dans Firebase
        let db = Firestore.firestore()
        db.collection("bills").addDocument(data: [
            "name": newBill.name,
            "amount": newBill.amount,
            "userID": newBill.userID
        ]) { error in
            if let error = error {
                print("Erreur lors de l'enregistrement de la facture : \(error)")
            } else {
                // Ajoutez la facture localement
                bills.append(newBill)
                
                // Réinitialiser les champs de saisie
                newBillName = ""
                newBillAmount = ""
            }
        }
    }
    
    // Fonction pour supprimer une facture
    func deleteBill(at offsets: IndexSet) {
        guard let currentUser = Auth.auth().currentUser else {
            // L'utilisateur n'est pas connecté
            return
        }
        
        // Supprimer la facture à partir de Firestore
        let db = Firestore.firestore()
        let billsRef = db.collection("bills")
        
        let billToDelete = bills[offsets.first!] // Obtenez la facture à supprimer
        
        billsRef
            .document(billToDelete.id.uuidString)
            .delete { error in
                if let error = error {
                    print("Erreur lors de la suppression de la facture : \(error.localizedDescription)")
                } else {
                    // La facture a été supprimée avec succès
                    self.bills.remove(atOffsets: offsets)
                }
            }
    }
}

struct BillManagementView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleBills: [Bill] = [
            Bill(name: "Facture 1", amount: 100.0, userID: ""),
            Bill(name: "Facture 2", amount: 200.0, userID: "")
        ]
        
        return BillManagementView(bills: .constant(sampleBills))
    }
}

struct Bill: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
    let userID: String // Ajoutez l'ID de l'utilisateur
}
