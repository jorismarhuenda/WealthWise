//
//  SubscriptionManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 06/09/2023.
//

import SwiftUI

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
    }
    
    func addSubscription() {
        let newSubscription = Subscription(name: newSubscriptionName, cost: newSubscriptionCost)
        subscriptions.append(newSubscription)
        newSubscriptionName = ""
        newSubscriptionCost = 0.0
    }
    
    func deleteSubscription(at offsets: IndexSet) {
        subscriptions.remove(atOffsets: offsets)
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
    var id = UUID()
    var name: String
    var cost: Double
}

struct SubscriptionManagementView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionManagementView()
    }
}
