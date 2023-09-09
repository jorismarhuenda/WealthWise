//
//  Transaction.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI
import Firebase

// Créez une structure de modèle de transaction
struct Transaction: Identifiable, Codable {
    var id: String
    var description: String
    var amount: Double
    var userID: String // Identifiant de l'utilisateur lié à cette transaction
    var date: Date
}

// Stockez une nouvelle transaction dans Firestore
func addTransaction(transaction: Transaction) {
    let db = Firestore.firestore()
    db.collection("transactions").addDocument(data: [
        "id": transaction.id,
        "description": transaction.description,
        "amount": transaction.amount,
        "userID": transaction.userID
    ])
}

// Récupérez les transactions de l'utilisateur actuellement connecté
func getTransactionsForCurrentUser(userID: String, completion: @escaping ([Transaction]?) -> Void) {
    let db = Firestore.firestore()
    db.collection("transactions")
        .whereField("userID", isEqualTo: userID)
        .getDocuments { (snapshot, error) in
            if let error = error {
                print("Erreur de récupération des transactions : \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            var transactions: [Transaction] = []
            for document in snapshot?.documents ?? [] {
                if let transaction = try? document.data(as: Transaction.self) {
                    transactions.append(transaction)
                }
            }
            
            completion(transactions)
        }
}
