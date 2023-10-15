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
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Informations de base sur la retraite")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    TextField("Âge actuel", text: $viewModel.currentAge)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()
                    
                    TextField("Âge prévu de départ à la retraite", text: $viewModel.retirementAge)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()
                    
                    Button(action: {
                        viewModel.saveRetirementInfo()
                    }) {
                        Text("Enregistrer")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 5))
                
                if let retirementInfo = viewModel.retirementInfo {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Récapitulatif des informations de retraite")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Text("Âge actuel : \(retirementInfo.currentAge)")
                        Text("Âge prévu de départ à la retraite : \(retirementInfo.retirementAge)")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 5))
                }
                
                NavigationLink(destination: RetirementPlanningCalculator()) {
                    Text("Calculateur de Planification de Retraite")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Suivi de la Retraite")
            .onAppear {
                viewModel.getRetirementInfo()
            }
            .sheet(isPresented: $isPlanningRetirement) {
                RetirementPlanningView()
            }
        }
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
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
