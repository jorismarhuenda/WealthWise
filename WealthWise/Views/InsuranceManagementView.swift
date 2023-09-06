//
//  InsuranceManagementView.swift
//  WealthWise
//
//  Created by marhuenda joris on 06/09/2023.
//

import SwiftUI

struct InsuranceManagementView: View {
    // Exemple de données fictives pour les polices d'assurance
    @State private var insurancePolicies = [
        InsurancePolicy(name: "Assurance Auto", premium: 500, beneficiaries: ["John Doe"]),
        InsurancePolicy(name: "Assurance Vie", premium: 1000, beneficiaries: ["Jane Smith"]),
    ]
    
    @State private var newPolicyName = ""
    @State private var newPolicyPremium = ""
    @State private var newBeneficiary = ""
    
    var body: some View {
        VStack {
            Text("Gestion des Assurances")
                .font(.title)
            
            List {
                ForEach(insurancePolicies.indices, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Text(insurancePolicies[index].name)
                            .font(.headline)
                        
                        Text("Prime mensuelle : $\(insurancePolicies[index].premium)")
                        
                        Text("Bénéficiaires : \(insurancePolicies[index].beneficiaries.joined(separator: ", "))")
                    }
                }
                .onDelete(perform: deleteInsurancePolicy)
            }
            
            Section(header: Text("Ajouter une Nouvelle Police d'Assurance")) {
                TextField("Nom de la police", text: $newPolicyName)
                TextField("Prime mensuelle", text: $newPolicyPremium)
                
                HStack {
                    TextField("Bénéficiaire", text: $newBeneficiary)
                    Button(action: addBeneficiary) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
                
                Button(action: addInsurancePolicy) {
                    Text("Ajouter une Police")
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
        }
        .padding()
    }
    
    func addInsurancePolicy() {
        if !newPolicyName.isEmpty, let premium = Double(newPolicyPremium) {
            let newPolicy = InsurancePolicy(name: newPolicyName, premium: premium, beneficiaries: [])
            insurancePolicies.append(newPolicy)
            newPolicyName = ""
            newPolicyPremium = ""
            newBeneficiary = ""
        }
    }
    
    func addBeneficiary() {
        if !newBeneficiary.isEmpty, let index = insurancePolicies.firstIndex(where: { $0.name == newPolicyName }) {
            insurancePolicies[index].beneficiaries.append(newBeneficiary)
            newBeneficiary = ""
        }
    }
    
    func deleteInsurancePolicy(at offsets: IndexSet) {
        insurancePolicies.remove(atOffsets: offsets)
    }
}

struct InsurancePolicy {
    var name: String
    var premium: Double
    var beneficiaries: [String]
}

struct InsuranceManagementView_Previews: PreviewProvider {
    static var previews: some View {
        InsuranceManagementView()
    }
}
