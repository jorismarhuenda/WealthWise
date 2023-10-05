//
//  InvestmentManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI
import Firebase

struct InvestmentManagementView: View {
    @State private var investments: [Investment] = [] // Liste des investissements
    @State private var newInvestmentName: String = ""
    @State private var newInvestmentQuantity: String = ""
    @State private var newInvestmentPrice: String = ""

    private var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }

    var body: some View {
        VStack {
            Text("Gestion des Investissements")
                .font(.title)
                .padding()

            List {
                ForEach(investments) { investment in
                    InvestmentRowView(investment: investment)
                }
                .onDelete(perform: deleteInvestment)
            }

            HStack {
                TextField("Nom de l'investissement", text: $newInvestmentName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Quantité", text: $newInvestmentQuantity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()

                TextField("Prix par unité", text: $newInvestmentPrice)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()

                Button(action: addInvestment) {
                    Text("Ajouter")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        NavigationLink(destination: InvestmentPortfolioView(investments: investments)) {
                            Text("Voir le Portfolio")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
        .onAppear(perform: fetchInvestments)
    }

    func addInvestment() {
        guard let currentUserID = currentUserID,
              let quantity = Int(newInvestmentQuantity),
              let price = Double(newInvestmentPrice) else {
            // L'utilisateur n'est pas connecté ou les données sont invalides
            return
        }

        let newInvestment = Investment(id: UUID().uuidString, name: newInvestmentName, quantity: quantity, pricePerUnit: price, userId: currentUserID)

        // Créer une référence à la collection "investments" dans Firestore
        let db = Firestore.firestore()
        let investmentsRef = db.collection("investments")

        // Créer un document pour l'investissement
        let investmentData: [String: Any] = [
            "name": newInvestment.name,
            "quantity": newInvestment.quantity,
            "pricePerUnit": newInvestment.pricePerUnit,
            "userId": newInvestment.userId
        ]

        investmentsRef.addDocument(data: investmentData) { error in
            if let error = error {
                print("Erreur lors de l'ajout de l'investissement : \(error.localizedDescription)")
            } else {
                // L'investissement a été ajouté avec succès
                fetchInvestments() // Mettre à jour la liste des investissements après l'ajout
                newInvestmentName = ""
                newInvestmentQuantity = ""
                newInvestmentPrice = ""
            }
        }
    }

    func fetchInvestments() {
        guard let currentUserID = currentUserID else {
            // L'utilisateur n'est pas connecté
            return
        }

        // Récupérer les investissements liés à l'utilisateur actuellement connecté depuis Firestore
        let db = Firestore.firestore()
        let investmentsRef = db.collection("investments")

        investmentsRef
            .whereField("userId", isEqualTo: currentUserID) // Filtrer par l'ID de l'utilisateur actuel
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Erreur lors de la récupération des investissements : \(error.localizedDescription)")
                } else if let documents = querySnapshot?.documents {
                    // Convertir les documents Firestore en objets Investment
                    let investments: [Investment] = documents.compactMap { document in
                        let data = document.data()
                        if let name = data["name"] as? String,
                           let quantity = data["quantity"] as? Int,
                           let pricePerUnit = data["pricePerUnit"] as? Double {
                            return Investment(id: document.documentID, name: name, quantity: quantity, pricePerUnit: pricePerUnit, userId: currentUserID)
                        } else {
                            return nil // Retourner nil si les valeurs ne sont pas valides
                        }
                    }
                    self.investments = investments
                }
            }
    }

    func deleteInvestment(at offsets: IndexSet) {
        guard let currentUserID = currentUserID else {
            // L'utilisateur n'est pas connecté
            return
        }

        // Supprimer l'investissement à partir de Firestore
        let db = Firestore.firestore()
        let investmentsRef = db.collection("investments")

        offsets.forEach { offset in
            let investmentToDelete = investments[offset] // Obtenez l'investissement à supprimer

            investmentsRef
                .whereField("id", isEqualTo: investmentToDelete.id)
                .whereField("userId", isEqualTo: currentUserID)
                .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Erreur lors de la suppression de l'investissement : \(error.localizedDescription)")
                    } else {
                        // Supprimez le document correspondant à l'investissement
                        for document in querySnapshot!.documents {
                            document.reference.delete { error in
                                if let error = error {
                                    print("Erreur lors de la suppression de l'investissement : \(error.localizedDescription)")
                                } else {
                                    // L'investissement a été supprimé avec succès
                                    if let index = self.investments.firstIndex(where: { $0.id == investmentToDelete.id }) {
                                        self.investments.remove(at: index)
                                    }
                                }
                            }
                        }
                    }
                }
        }
    }
}

struct InvestmentRowView: View {
    let investment: Investment

    var body: some View {
        HStack {
            Text(investment.name)
            Spacer()
            Text("\(investment.quantity) actions")
            Text("\(investment.totalValue, specifier: "%.2f") €")
        }
    }
}

struct Investment: Identifiable {
    var id: String
    var name: String
    var quantity: Int
    var pricePerUnit: Double
    var userId: String

    var totalValue: Double {
        return Double(quantity) * pricePerUnit
    }
}

struct InvestmentManagementView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentManagementView()
    }
}
