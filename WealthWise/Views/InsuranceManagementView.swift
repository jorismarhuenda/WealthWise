//
//  InsuranceManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 06/09/2023.
//

import SwiftUI
import Firebase

struct InsuranceManagementView: View {
    @State private var insurancePolicies: [InsurancePolicy] = [] // Liste des polices d'assurance
    @State private var newPolicyName: String = ""
    @State private var newPolicyPremium: String = ""
    @State private var newBeneficiary: String = ""
    
    private var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }
    
    var body: some View {
        VStack {
            Text("Gestion des Assurances")
                .font(.title)
                .padding()
            
            List {
                ForEach(insurancePolicies) { policy in
                    InsurancePolicyRow(policy: policy)
                }
                .onDelete(perform: deleteInsurancePolicy)
            }
            
            HStack {
                TextField("Nom de la police", text: $newPolicyName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Prime mensuelle", text: $newPolicyPremium)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()
                
                Button(action: addInsurancePolicy) {
                    Text("Ajouter")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .onAppear(perform: fetchInsurancePolicies)
    }
    
    func addInsurancePolicy() {
        guard let currentUserID = currentUserID else {
               // L'utilisateur n'est pas connecté
               return
           }
        
        if let premium = Double(newPolicyPremium) {
            let newPolicy = InsurancePolicy(id: UUID().uuidString, name: newPolicyName, premium: premium, beneficiaries: [], userID: currentUserID)
            
            // Créer une référence à la collection "insurancePolicies" dans Firestore
            let db = Firestore.firestore()
            let insurancePoliciesRef = db.collection("insurancePolicies")
            
            // Créer un document pour la police d'assurance
            let policyData: [String: Any] = [
                "name": newPolicy.name,
                "premium": newPolicy.premium,
                "beneficiaries": newPolicy.beneficiaries,
                "userID": newPolicy.userID
            ]
            
            insurancePoliciesRef.addDocument(data: policyData) { error in
                if let error = error {
                    print("Erreur lors de l'ajout de la police d'assurance : \(error.localizedDescription)")
                } else {
                    // La police d'assurance a été ajoutée avec succès
                    fetchInsurancePolicies() // Mettre à jour la liste des polices après l'ajout
                    newPolicyName = ""
                    newPolicyPremium = ""
                    newBeneficiary = ""
                }
            }
        }
    }
    
    func fetchInsurancePolicies() {
        guard let currentUserID = currentUserID else {
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
    
    func deleteInsurancePolicy(at offsets: IndexSet) {
        guard let currentUserID = currentUserID else {
                // L'utilisateur n'est pas connecté
                return
            }
        
        // Supprimer la police d'assurance à partir de Firestore
        let db = Firestore.firestore()
        let insurancePoliciesRef = db.collection("insurancePolicies")
        
        let policyToDelete = insurancePolicies[offsets.first!] // Obtenez la police d'assurance à supprimer
        
        insurancePoliciesRef
            .document(policyToDelete.id)
            .delete { error in
                if let error = error {
                    print("Erreur lors de la suppression de la police d'assurance : \(error.localizedDescription)")
                } else {
                    // La police d'assurance a été supprimée avec succès
                    self.insurancePolicies.remove(atOffsets: offsets)
                }
            }
    }
}

struct InsurancePolicyRow: View {
    var policy: InsurancePolicy
    
    var body: some View {
        HStack {
            Text(policy.name)
            Spacer()
            Text("$\(policy.premium, specifier: "%.2f")/mois")
        }
    }
}

struct InsurancePolicy: Identifiable {
    var id: String
    var name: String
    var premium: Double
    var beneficiaries: [String]
    var userID: String
}

struct InsuranceManagementView_Previews: PreviewProvider {
    static var previews: some View {
        InsuranceManagementView()
    }
}
