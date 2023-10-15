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
    private let deletedTransactionsKey = "deletedTransactions"

    private var deletedTransactions: [DeletedTransaction] {
            get {
                if let data = UserDefaults.standard.data(forKey: deletedTransactionsKey) {
                    do {
                        return try JSONDecoder().decode([DeletedTransaction].self, from: data)
                    } catch {
                        print("Erreur lors de la récupération des transactions supprimées : \(error)")
                    }
                }
                return []
            }
            set {
                do {
                    let data = try JSONEncoder().encode(newValue)
                    UserDefaults.standard.set(data, forKey: deletedTransactionsKey)
                } catch {
                    print("Erreur lors de la sauvegarde des transactions supprimées : \(error)")
                }
            }
        }
    
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

            // Ajoutez la transaction localement après l'avoir ajoutée à Firestore
            self.transactions.append(addedTransaction)
        } catch {
            print("Erreur lors de l'ajout de la transaction : \(error)")
        }
    }

    func fetchTransactions() {
        // Assurez-vous que l'utilisateur est connecté avant de récupérer les transactions
        guard let userID = user?.uid else { return }

        db.collection("transactions")
            .whereField("userID", isEqualTo: userID) // Filtrez les transactions par utilisateur
            .getDocuments { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Aucune transaction trouvée : \(error?.localizedDescription ?? "Erreur inconnue")")
                    return
                }

                self.transactions = documents.compactMap { queryDocumentSnapshot in
                    do {
                        let transaction = try queryDocumentSnapshot.data(as: Transaction.self)
                        // Excluez les transactions supprimées
                        return self.deletedTransactions.contains { $0.id == transaction?.id } ? nil : transaction
                    } catch {
                        print("Erreur de lecture de la transaction : \(error)")
                        return nil
                    }
                }
            }
    }

    func deleteTransaction(transaction: Transaction) {
        let db = Firestore.firestore()
        
        let deletedTransaction = DeletedTransaction(id: transaction.id)
                deletedTransactions.append(deletedTransaction)

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
                // Mettez à jour localement les transactions après la suppression
                self.transactions.removeAll { $0.id == transaction.id }
            }
        }
    }
}

struct DeletedTransaction: Codable {
    var id: String
}
