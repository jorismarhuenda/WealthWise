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
                            DebtCardView(debt: debt)
                                .padding(.vertical, 5)
                        }
                    }
                    .onDelete(perform: deleteDebt)
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Gestion de Dettes", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    isAddingDebt = true
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                })
            }
            .sheet(isPresented: $isAddingDebt) {
                AddDebtView(debts: $debts, isAddingDebt: $isAddingDebt, newDebtName: $newDebtName, newDebtAmount: $newDebtAmount)
            }
            .onAppear {
                fetchDebts()
            }
        }
    }

    func fetchDebts() {
        if let user = Auth.auth().currentUser {
            let userId = user.uid
            let db = Firestore.firestore()
            db.collection("users").document(userId).collection("debts").getDocuments { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Erreur lors de la récupération des dettes: \(error?.localizedDescription ?? "Erreur inconnue")")
                    return
                }
                DispatchQueue.main.async {
                    debts = documents.compactMap { queryDocumentSnapshot -> Debt? in
                        let data = queryDocumentSnapshot.data()
                        guard let id = queryDocumentSnapshot.documentID as? String,
                              let name = data["name"] as? String,
                              let amount = data["amount"] as? Double,
                              let userId = data["userId"] as? String,
                              userId == user.uid else {
                            return nil
                        }
                        return Debt(id: id, name: name, amount: amount, userId: userId)
                    }
                }
            }
        }
    }

    func deleteDebt(at offsets: IndexSet) {
        guard let user = Auth.auth().currentUser else {
            return
        }

        let userId = user.uid
        let db = Firestore.firestore()
        let debtsRef = db.collection("users").document(userId).collection("debts")

        let debtsToDelete = offsets.map { debts[$0] }

        let dispatchGroup = DispatchGroup()

        for debtToDelete in debtsToDelete {
            dispatchGroup.enter()
            let debtDocRef = debtsRef.document(debtToDelete.id)

            debtDocRef.delete { error in
                if let error = error {
                    print("Erreur lors de la suppression de la dette dans Firestore: \(error.localizedDescription)")
                } else {
                    print("Dette supprimée avec succès: \(debtToDelete.name)")
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            for debtToDelete in debtsToDelete {
                if let index = self.debts.firstIndex(where: { $0.id == debtToDelete.id }) {
                    self.debts.remove(at: index)
                    print("Dette supprimée localement: \(debtToDelete.name)")
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
}

struct DebtCardView: View {
    let debt: Debt

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(debt.name)
                .font(.headline)
                .foregroundColor(.blue)
            Text("Montant: \(debt.amount, specifier: "%.2f") €")
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        )
    }
}

struct DebtDetailView: View {
    let debt: Debt

    var body: some View {
        VStack(spacing: 20) {
            Text("Nom de la dette : \(debt.name)")
                .font(.title)
                .foregroundColor(.blue)
            
            Text("Montant de la dette : \(debt.amount, specifier: "%.2f")€")
                .font(.title2)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .navigationBarTitle("Détails de la Dette", displayMode: .inline)
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
                Section(header: Text("Nouvelle Dette").font(.headline).foregroundColor(.blue)) {
                    TextField("Nom de la dette", text: $newDebtName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    
                    TextField("Montant de la dette", text: $newDebtAmount)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                }

                Button(action: {
                    if let amount = Double(newDebtAmount) {
                        saveDebtToFirestore(name: newDebtName, amount: amount)
                    }
                    isAddingDebt = false
                }) {
                    Text("Ajouter Dette")
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
            .navigationBarTitle("Ajouter Dette", displayMode: .inline)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.05), Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
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
