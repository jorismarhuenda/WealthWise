//
//  SavingsPlanningView.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI

struct SavingsPlanningView: View {
    @State private var shortTermGoal: Double = 0
    @State private var longTermGoal: Double = 0
    @State private var currentSavings: Double = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Planification de l'Épargne")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .padding(.top, 20)

            VStack(spacing: 15) {
                SavingsGoalSection(title: "Objectif d'Épargne à Court Terme", value: $shortTermGoal)
                SavingsGoalSection(title: "Objectif d'Épargne à Long Terme", value: $longTermGoal)
                SavingsGoalSection(title: "Économies Actuelles", value: $currentSavings)
            }
            .padding(.horizontal)

            Spacer()

            Button(action: {
                // Logique pour enregistrer les objectifs d'épargne et les économies actuelles
            }) {
                Text("Enregistrer")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.05), Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct SavingsGoalSection: View {
    var title: String
    @Binding var value: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
            
            TextField("Montant en euros", value: $value, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}

struct SavingsPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        SavingsPlanningView()
    }
}
