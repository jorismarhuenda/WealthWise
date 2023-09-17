//
//  RetirementTrackerView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct RetirementTrackerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isPlanningRetirement = false
    
    @ObservedObject var viewModel = RetirementInfoViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Suivi de la Retraite")
                    .font(.title)
                
                VStack(alignment: .leading) {
                    Text("Informations de base sur la retraite")
                        .font(.headline)
                    
                    TextField("Âge actuel", text: $viewModel.currentAge)
                        .keyboardType(.numberPad)
                    
                    TextField("Âge prévu de départ à la retraite", text: $viewModel.retirementAge)
                        .keyboardType(.numberPad)
                    
                    Button(action: {
                        viewModel.saveRetirementInfo()
                    }) {
                        Text("Enregistrer")
                    }
                }
                
                if let retirementInfo = viewModel.retirementInfo {
                    VStack(alignment: .leading) {
                        Text("Récapitulatif des informations de retraite")
                            .font(.headline)
                        
                        Text("Âge actuel : \(retirementInfo.currentAge)")
                        Text("Âge prévu de départ à la retraite : \(retirementInfo.retirementAge)")
                    }
                }
                
                NavigationLink(destination: RetirementPlanningCalculator()) {
                    Text("Calculateur de Planification de Retraite")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Suivi de la Retraite")
            .onAppear {
                viewModel.getRetirementInfo()
            }
            .sheet(isPresented: $isPlanningRetirement) {
                // Affiche la vue de planification de la retraite en tant que feuille modale
                RetirementPlanningView()
            }
        }
    }
}

struct RetirementTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        RetirementTrackerView()
    }
}

class RetirementInfoViewModel: ObservableObject {
    @Published var currentAge = ""
    @Published var retirementAge = ""
    @Published var retirementInfo: RetirementInfo? = nil
    
    func saveRetirementInfo() {
        if let currentAgeInt = Int(currentAge), let retirementAgeInt = Int(retirementAge) {
            let retirementInfo = RetirementInfo(currentAge: currentAgeInt, retirementAge: retirementAgeInt)
            self.retirementInfo = retirementInfo
            saveRetirementInfoToFirebase(retirementInfo)
        }
    }
    
    func getRetirementInfo() {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            
            let db = Firestore.firestore()
            let retirementRef = db.collection("users").document(userID).collection("retirementInfo").document("userRetirementInfo")
            
            retirementRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    if let currentAge = data?["currentAge"] as? Int, let retirementAge = data?["retirementAge"] as? Int {
                        DispatchQueue.main.async {
                            self.currentAge = String(currentAge)
                            self.retirementAge = String(retirementAge)
                            self.retirementInfo = RetirementInfo(currentAge: currentAge, retirementAge: retirementAge)
                        }
                    }
                }
            }
        }
    
    func saveRetirementInfoToFirebase(_ retirementInfo: RetirementInfo) {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            
            let db = Firestore.firestore()
            let retirementRef = db.collection("users").document(userID).collection("retirementInfo").document("userRetirementInfo")
            
            retirementRef.setData([
                "currentAge": retirementInfo.currentAge,
                "retirementAge": retirementInfo.retirementAge
            ]) { error in
                if let error = error {
                    print("Erreur lors de l'enregistrement des informations de retraite : \(error.localizedDescription)")
                } else {
                    print("Informations de retraite enregistrées avec succès")
                }
            }
        }
}

struct RetirementInfo {
    var currentAge: Int
    var retirementAge: Int
}
