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
        VStack(spacing: 20) {
            Text("Gestion des Investissements")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .padding(.top, 20)

            List {
                ForEach(investments) { investment in
                    InvestmentCardView(investment: investment)
                        .padding(.vertical, 5)
                }
                .onDelete(perform: deleteInvestment)
            }
            .listStyle(PlainListStyle())

            VStack(spacing: 15) {
                TextField("Nom de l'investissement", text: $newInvestmentName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)

                TextField("Quantité", text: $newInvestmentQuantity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)

                TextField("Prix par unité", text: $newInvestmentPrice)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)

                Button(action: addInvestment) {
                    Text("Ajouter")
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
            .padding()
            
            NavigationLink(destination: InvestmentPortfolioView(investments: investments)) {
                Text("Voir le Portfolio")
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
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.05), Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear(perform: fetchInvestments)
    }

    func addInvestment() {
        guard let currentUserID = currentUserID,
              let quantity = Int(newInvestmentQuantity),
              let price = Double(newInvestmentPrice) else {
            return
        }

        let newInvestment = Investment(id: UUID().uuidString, name: newInvestmentName, quantity: quantity, pricePerUnit: price, userId: currentUserID)
        let db = Firestore.firestore()
        let investmentsRef = db.collection("investments")
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
                fetchInvestments()
                newInvestmentName = ""
                newInvestmentQuantity = ""
                newInvestmentPrice = ""
            }
        }
    }

    func fetchInvestments() {
        guard let currentUserID = currentUserID else {
            return
        }

        let db = Firestore.firestore()
        let investmentsRef = db.collection("investments")

        investmentsRef
            .whereField("userId", isEqualTo: currentUserID)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Erreur lors de la récupération des investissements : \(error.localizedDescription)")
                } else if let documents = querySnapshot?.documents {
                    let investments: [Investment] = documents.compactMap { document in
                        let data = document.data()
                        if let name = data["name"] as? String,
                           let quantity = data["quantity"] as? Int,
                           let pricePerUnit = data["pricePerUnit"] as? Double {
                            return Investment(id: document.documentID, name: name, quantity: quantity, pricePerUnit: pricePerUnit, userId: currentUserID)
                        } else {
                            return nil
                        }
                    }
                    self.investments = investments
                }
            }
    }

    func deleteInvestment(at offsets: IndexSet) {
        guard let currentUserID = currentUserID else {
            return
        }

        let db = Firestore.firestore()
        let investmentsRef = db.collection("investments")

        let investmentsToDelete = offsets.map { investments[$0] }

        for investmentToDelete in investmentsToDelete {
            investmentsRef
                .document(investmentToDelete.id)
                .delete { error in
                    if let error = error {
                        print("Erreur lors de la suppression de l'investissement : \(error.localizedDescription)")
                    } else {
                        if let index = self.investments.firstIndex(where: { $0.id == investmentToDelete.id }) {
                            self.investments.remove(at: index)
                        }
                    }
                }
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
