//
//  WealthSummaryView.swift
//  WealthWise
//
//  Created by marhuenda joris on 05/09/2023.
//

import SwiftUI
import Firebase

struct WealthSummaryView: View {
    @State private var investments: [Investment] = []
    @State private var debts: [Debt] = []
    @State private var bills: [Bill] = []
    @State private var insurancePolicies: [InsurancePolicy] = []
    @State private var subscriptions: [Subscription] = []

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Section Actifs (Investissements)
                    WealthSectionView(title: "Investissements", items: investments.map { WealthItem(name: $0.name, value: $0.totalValue) }, isPositive: true)

                    // Section Dettes
                    WealthSectionView(title: "Dettes", items: debts.map { WealthItem(name: $0.name, value: $0.amount, isDebt: true) }, isPositive: false)

                    // Section Factures
                    WealthSectionView(title: "Factures", items: bills.map { WealthItem(name: $0.name, value: $0.amount) }, isPositive: false)

                    // Section Polices d'Assurance
                    WealthSectionView(title: "Assurances", items: insurancePolicies.map { WealthItem(name: $0.name, value: $0.premium) }, isPositive: false)

                    // Section Abonnements
                    WealthSectionView(title: "Abonnements", items: subscriptions.map { WealthItem(name: $0.name, value: $0.cost) }, isPositive: false)

                    // Section Valeur Nette
                    WealthNetWorthView(investments: investments, debts: debts, bills: bills, insurancePolicies: insurancePolicies, subscriptions: subscriptions)
                        .padding(.top, 20)
                }
                .padding()
            }
            .navigationTitle("Résumé de la Richesse")
            .onAppear {
                fetchInvestments()
                fetchDebts()
                fetchBills()
                fetchInsurancePolicies()
                fetchSubscriptions()
            }
        }
    }

    func fetchInvestments() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
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

    func fetchBills() {
        guard let user = Auth.auth().currentUser else {
            return // L'utilisateur n'est pas connecté, gestion de l'erreur
        }
        
        let db = Firestore.firestore()
        db.collection("bills")
            .whereField("userID", isEqualTo: user.uid) // Filtrer par ID utilisateur
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Erreur lors du chargement des factures : \(error)")
                } else if let documents = snapshot?.documents {
                    bills = documents.compactMap { document in
                        if let data = document.data() as? [String: Any],
                           let name = data["name"] as? String,
                           let amount = data["amount"] as? Double {
                            return Bill(name: name, amount: amount, userID: user.uid)
                        }
                        return nil
                    }
                }
            }
    }
    
    func fetchInsurancePolicies() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
                    // L'utilisateur n'est pas connecté
                    return
                }
        
        // Récupérer les polices d'assurance liées à l'utilisateur actuellement connecté depuis Firestore
        let db = Firestore.firestore()
        let insurancePoliciesRef = db.collection("insurancePolicies")
        
        insurancePoliciesRef
            .whereField("userID", isEqualTo: currentUserID) // Filtrer par l'ID de l'utilisateur actuel
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Erreur lors de la récupération des polices d'assurance : \(error.localizedDescription)")
                } else if let documents = querySnapshot?.documents {
                    // Convertir les documents Firestore en objets InsurancePolicy
                    let policies: [InsurancePolicy] = documents.compactMap { document in
                        let data = document.data()
                        if let name = data["name"] as? String,
                           let premium = data["premium"] as? Double,
                           let beneficiaries = data["beneficiaries"] as? [String] {
                            return InsurancePolicy(id: document.documentID, name: name, premium: premium, beneficiaries: beneficiaries, userID: currentUserID)
                        } else {
                            return nil // Retourner nil si les valeurs ne sont pas valides
                        }
                    }
                    self.insurancePolicies = policies
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
}

struct WealthItem: Identifiable {
    var id = UUID()
    var name: String
    var value: Double
    var isDebt: Bool = false
}

struct WealthSectionView: View {
    var title: String
    var items: [WealthItem]
    var isPositive: Bool

    var body: some View {
        Section(header: Text(title).font(.headline)) {
            List {
                ForEach(items) { item in
                    WealthItemView(name: item.name, value: item.value, isPositive: isPositive, isDebt: item.isDebt)
                }
            }
            .frame(height: 120) // Ajuster la hauteur en fonction de la quantité d'éléments
        }
    }
}

struct WealthItemView: View {
    var name: String
    var value: Double
    var isPositive: Bool
    var isDebt: Bool = false

    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text("\(isPositive ? "+" : "-")€\(abs(value), specifier: "%.2f")")
                .foregroundColor(isPositive ? .green : .red)
        }
    }
}

struct WealthNetWorthView: View {
    var investments: [Investment]
    var debts: [Debt]
    var bills: [Bill]
    var insurancePolicies: [InsurancePolicy]
    var subscriptions: [Subscription]

    var body: some View {
        VStack {
            Text("Valeur Nette")
                .font(.headline)

            // Calculate net worth by subtracting debts, bills, insurance premiums, and subscriptions from assets
            let netWorth = calculateNetWorth()
            Text("\(netWorth, specifier: "%.2f") €")
                .font(.title)
                .foregroundColor(netWorth >= 0 ? .green : .red)
        }
        .padding()
    }

    func calculateNetWorth() -> Double {
        let assets = investments.reduce(0) { $0 + $1.totalValue }
        let debts = self.debts.reduce(0) { $0 + $1.amount }
        let bills = self.bills.reduce(0) { $0 + $1.amount }
        let insurancePremiums = insurancePolicies.reduce(0) { $0 + $1.premium }
        let subscriptions = self.subscriptions.reduce(0) { $0 + $1.cost }

        return assets - debts - bills - insurancePremiums - subscriptions
    }
}

// ... (Investment, Debt, Bill, InsurancePolicy, Subscription structures and extensions)
