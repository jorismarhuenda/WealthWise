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
        NavigationView {
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
            .onReceive(debts.publisher) { _ in
                // Force la mise à jour de la vue lorsqu'il y a des changements dans la liste debts
                self.fetchDebts()
            }
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
                DispatchQueue.main.async {
                    debts = documents.compactMap { queryDocumentSnapshot -> Debt? in
                        let data = queryDocumentSnapshot.data()
                        guard let id = queryDocumentSnapshot.documentID as? String,
                              let name = data["name"] as? String,
                              let amount = data["amount"] as? Double,
                              let userId = data["userId"] as? String,
                              userId == user.uid else {
                            return nil // Ignorer les dettes qui ne correspondent pas à l'utilisateur actuel
                        }
                        return Debt(id: id, name: name, amount: amount, userId: userId)
                    }
                }
            }
        }
    }

    func deleteDebt(at offsets: IndexSet) {
        guard let user = Auth.auth().currentUser else {
            // L'utilisateur n'est pas connecté
            return
        }

        let userId = user.uid
        let db = Firestore.firestore()
        let debtsRef = db.collection("users").document(userId).collection("debts")

        let debtsToDelete = offsets.map { debts[$0] } // Obtenez la liste des dettes à supprimer

        let dispatchGroup = DispatchGroup()

        for debtToDelete in debtsToDelete {
            dispatchGroup.enter()

            let debtDocRef = debtsRef.document(debtToDelete.id)

            print("Avant suppression sur Firebase - Dette ID: \(debtToDelete.id)")

            debtDocRef.delete { error in
                if let error = error {
                    print("Erreur lors de la suppression de la dette dans Firestore: \(error.localizedDescription)")
                } else {
                    // La dette a été supprimée avec succès
                    print("Dette supprimée avec succès: \(debtToDelete.name)")
                }
                dispatchGroup.leave()
            }

            print("Après suppression sur Firebase - Dette ID: \(debtToDelete.id)")
        }

        dispatchGroup.notify(queue: .main) {
            // Toutes les suppressions sur Firebase sont terminées, maintenant supprimons les dettes localement
            for debtToDelete in debtsToDelete {
                if let index = self.debts.firstIndex(where: { $0.id == debtToDelete.id }) {
                    self.debts.remove(at: index)
                    print("Dette supprimée localement: \(debtToDelete.name)")
                } else {
                    print("Impossible de trouver la dette localement: \(debtToDelete.name)")
                }
            }
            print("Toutes les suppressions sont terminées")
        }
    }
}

struct Debt: Identifiable {
    let id: String
    let name: String
    let amount: Double
    let userId: String
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
                "name": name,
                "amount": amount,
                "userId": userId
            ]

            db.collection("users").document(userId).collection("debts").addDocument(data: debtData) { error in
                if let error = error {
                    print("Erreur lors de l'ajout de la dette: \(error.localizedDescription)")
                } else {
                    print("Dette ajoutée avec succès à Firebase: \(name)")
                }
            }
        }
    }
}
