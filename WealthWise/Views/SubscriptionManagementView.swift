//
//  SubscriptionManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 06/09/2023.
//

import SwiftUI
import Firebase

struct SubscriptionManagementView: View {
    @State private var subscriptions: [Subscription] = [] // Liste des abonnements
    @State private var newSubscriptionName: String = ""
    @State private var newSubscriptionCost: Double = 0.0
    
    var body: some View {
        VStack {
            Text("Gestion des Abonnements et des Services")
                .font(.title)
                .padding()
            
            List {
                ForEach(subscriptions, id: \.id) { subscription in
                    SubscriptionRow(subscription: subscription)
                }
                .onDelete(perform: deleteSubscription)
            }
            
            HStack {
                TextField("Nom de l'abonnement", text: $newSubscriptionName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Coût mensuel", value: $newSubscriptionCost, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()
                
                Button(action: addSubscription) {
                    Text("Ajouter")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .onAppear(perform: fetchSubscriptions)
    }
    
    func addSubscription() {
        guard let currentUser = Auth.auth().currentUser else {
            // L'utilisateur n'est pas connecté
            return
        }
        
        let newSubscription = Subscription(id: UUID().uuidString, name: newSubscriptionName, cost: newSubscriptionCost)
        
        // Créer une référence à la collection "subscriptions" dans Firestore
        let db = Firestore.firestore()
        let subscriptionsRef = db.collection("subscriptions")
        
        // Créer un document pour l'abonnement
        let subscriptionData: [String: Any] = [
            "name": newSubscription.name,
            "cost": newSubscription.cost,
            "userId": currentUser.uid
        ]
        
        subscriptionsRef.addDocument(data: subscriptionData) { error in
            if let error = error {
                print("Erreur lors de l'ajout de l'abonnement : \(error.localizedDescription)")
            } else {
                // L'abonnement a été ajouté avec succès
                fetchSubscriptions() // Mettre à jour la liste des abonnements après l'ajout
                newSubscriptionName = ""
                newSubscriptionCost = 0.0
            }
        }
    }
    
    func fetchSubscriptions() {
        guard let currentUser = Auth.auth().currentUser else {
            // L'utilisateur n'est pas connecté
            return
        }
        
        // Récupérer les abonnements liés à l'utilisateur actuellement connecté depuis Firestore
        let db = Firestore.firestore()
        let subscriptionsRef = db.collection("subscriptions")
        
        subscriptionsRef
            .whereField("userId", isEqualTo: currentUser.uid) // Filtrer par l'ID de l'utilisateur actuel
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Erreur lors de la récupération des abonnements : \(error.localizedDescription)")
                } else if let documents = querySnapshot?.documents {
                    // Convertir les documents Firestore en objets Subscription
                    let subscriptions: [Subscription] = documents.compactMap { document in
                        let data = document.data()
                        if let name = data["name"] as? String,
                           let cost = data["cost"] as? Double {
                            return Subscription(id: document.documentID, name: name, cost: cost)
                        } else {
                            return nil // Retourner nil si les valeurs ne sont pas valides
                        }
                    }
                    self.subscriptions = subscriptions
                }
            }
    }
    
    func deleteSubscription(at offsets: IndexSet) {
        guard let currentUser = Auth.auth().currentUser else {
            // L'utilisateur n'est pas connecté
            return
        }
        
        // Supprimer l'abonnement à partir de Firestore
        let db = Firestore.firestore()
        let subscriptionsRef = db.collection("subscriptions")
        
        let subscriptionToDelete = subscriptions[offsets.first!] // Obtenez l'abonnement à supprimer
        
        subscriptionsRef
            .document(subscriptionToDelete.id)
            .delete { error in
                if let error = error {
                    print("Erreur lors de la suppression de l'abonnement : \(error.localizedDescription)")
                } else {
                    // L'abonnement a été supprimé avec succès
                    self.subscriptions.remove(atOffsets: offsets)
                }
            }
    }
}

struct SubscriptionRow: View {
    var subscription: Subscription
    
    var body: some View {
        HStack {
            Text(subscription.name)
            Spacer()
            Text("$\(subscription.cost, specifier: "%.2f")/mois")
        }
    }
}

struct Subscription {
    var id: String
    var name: String
    var cost: Double
}

struct SubscriptionManagementView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionManagementView()
    }
}
