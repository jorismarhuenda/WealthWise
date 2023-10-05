//
//  DebtManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

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
                .onDelete(perform: deleteDebt)
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
        .onAppear {
            fetchDebts()
        }
    }

    func fetchDebts() {
        // Vérifier si l'utilisateur est authentifié
        if let user = Auth.auth().currentUser {
            let userId = user.uid
            
            // Accéder à la collection "debts" dans Firestore
            let db = Firestore.firestore()
            db.collection("users").document(userId).collection("debts").getDocuments { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Erreur lors de la récupération des dettes: \(error?.localizedDescription ?? "Erreur inconnue")")
                    return
                }
                
                // Mettre à jour la liste locale avec les nouvelles données
                debts = documents.compactMap { queryDocumentSnapshot -> Debt? in
                    let data = queryDocumentSnapshot.data()
                    guard let id = data["id"] as? String,
                          let name = data["name"] as? String,
                          let amount = data["amount"] as? Double,
                          let userId = data["userId"] as? String,
                          userId == user.uid else {
                        return nil // Ignorer les dettes qui ne correspondent pas à l'utilisateur actuel
                    }
                    return Debt(id: id, name: name, amount: amount)
                }
            }
        }
    }

    func deleteDebt(at offsets: IndexSet) {
        // Marquer les dettes comme supprimées localement
        offsets.forEach { index in
            if debts.indices.contains(index) {
                debts[index].isDeleted = true
            }
        }
        
        // Mettre à jour la liste locale
        debts.removeAll { debt in
            return debt.isDeleted
        }
        
        // Supprimer les dettes de Firestore
        if let user = Auth.auth().currentUser {
            let userId = user.uid
            let db = Firestore.firestore()
            
            offsets.forEach { index in
                if debts.indices.contains(index) {
                    let debtToDelete = debts[index]
                    let documentId = debtToDelete.id
                    
                    print("Tentative de suppression de la dette avec l'ID \(documentId)")
                    
                    db.collection("users").document(userId).collection("debts").document(documentId).delete { error in
                        if let error = error {
                            print("Erreur lors de la suppression de la dette dans Firestore: \(error.localizedDescription)")
                        } else {
                            print("La dette avec l'ID \(documentId) a été supprimée avec succès de Firestore")
                        }
                    }
                }
            }
        }
    }
}

struct Debt: Identifiable {
    let id: String
    let name: String
    let amount: Double
    var isDeleted: Bool = false
}

struct DebtDetailView: View {
    let debt: Debt
    
    var body: some View {
        VStack {
            Text("Nom de la dette : \(debt.name)")
            Text("Montant de la dette : \(debt.amount)€")
            // Ajoutez d'autres détails de la dette si nécessaire
        }
        .navigationBarTitle("Détails de la Dette")
    }
}

struct AddDebtView: View {
    @Binding var debts: [Debt]
    @Binding var isAddingDebt: Bool
    @Binding var newDebtName: String
    @Binding var newDebtAmount: String
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nouvelle Dette")) {
                    TextField("Nom de la dette", text: $newDebtName)
                    TextField("Montant de la dette", text: $newDebtAmount)
                        .keyboardType(.numberPad)
                }
                
                Button(action: {
                    if let amount = Double(newDebtAmount) {
                        saveDebtToFirestore(name: newDebtName, amount: amount)
                    }
                    isAddingDebt = false
                }) {
                    Text("Ajouter Dette")
                }
            }
            .navigationBarTitle("Ajouter Dette")
        }
    }

    func saveDebtToFirestore(name: String, amount: Double) {
        if let user = Auth.auth().currentUser {
            let userId = user.uid
            
            let db = Firestore.firestore()
            let debtData: [String: Any] = [
                "id": UUID().uuidString,
                "name": name,
                "amount": amount,
                "userId": userId
            ]
            
            db.collection("users").document(userId).collection("debts").addDocument(data: debtData) { error in
                if let error = error {
                    print("Erreur lors de l'ajout de la dette: \(error.localizedDescription)")
                } else {
                    let newDebt = Debt(id: debtData["id"] as! String, name: name, amount: amount)
                    debts.append(newDebt)
                }
            }
        }
    }
}
