//
//  TransactionManager.swift
//  WealthWise
//
//  Created by marhuenda joris on 09/09/2023.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class TransactionManager: ObservableObject {
    private var db = Firestore.firestore()
    private let user = Auth.auth().currentUser // Récupérez l'utilisateur actuellement connecté

    @Published var transactions: [Transaction] = []

    init() {
        fetchTransactions()
    }

    func addTransaction(transaction: Transaction) {
        // Assurez-vous que l'utilisateur est connecté avant d'ajouter la transaction
        guard let userID = user?.uid else { return }

        do {
            var addedTransaction = transaction
            addedTransaction.userID = userID // Liez la transaction à l'utilisateur
            _ = try db.collection("transactions").addDocument(from: addedTransaction)
        } catch {
            print("Erreur lors de l'ajout de la transaction : \(error)")
        }
    }

    func fetchTransactions() {
        // Assurez-vous que l'utilisateur est connecté avant de récupérer les transactions
        guard let userID = user?.uid else { return }

        db.collection("transactions")
            .whereField("userID", isEqualTo: userID) // Filtrez les transactions par utilisateur
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Aucune transaction trouvée : \(error?.localizedDescription ?? "Erreur inconnue")")
                    return
                }

                self.transactions = documents.compactMap { queryDocumentSnapshot in
                    do {
                        return try queryDocumentSnapshot.data(as: Transaction.self)
                    } catch {
                        print("Erreur de lecture de la transaction : \(error)")
                        return nil
                    }
                }
            }
    }
    
    func deleteTransaction(transaction: Transaction) {
        let db = Firestore.firestore()
        
        // Vérifiez si l'utilisateur actuel est autorisé à supprimer cette transaction
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("L'utilisateur n'est pas connecté.")
            return
        }
        
        // Vérifiez si l'identifiant de l'utilisateur correspond à l'identifiant de l'utilisateur associé à la transaction
        guard transaction.userID == currentUserID else {
            print("L'utilisateur actuel n'est pas autorisé à supprimer cette transaction.")
            return
        }
        
        // Supprimez la transaction de la base de données
        db.collection("transactions").document(transaction.id).delete { error in
            if let error = error {
                print("Erreur lors de la suppression de la transaction : \(error.localizedDescription)")
            } else {
                print("Transaction supprimée avec succès.")
            }
        }
    }
}