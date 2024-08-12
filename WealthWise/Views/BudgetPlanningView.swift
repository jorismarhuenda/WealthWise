//
//  BudgetPlanningView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct BudgetPlanningView: View {
    @State private var income: Double = 0
    @State private var expenses: Double = 0
    @State private var budget: Double = 0
    @State private var budgetCalculated = false
    @State private var bills: [Bill] = []
    @ObservedObject var transactionManager: TransactionManager
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Planification de Budget")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .padding(.top, 40)
            
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 25))
                    
                    TextField("Revenu mensuel", value: $income, formatter: NumberFormatter())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                
                HStack {
                    Image(systemName: "cart.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 25))
                    
                    TextField("Dépenses mensuelles", value: $expenses, formatter: NumberFormatter())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue.opacity(0.1))
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            )
            
            Button(action: {
                budget = income - expenses
                budgetCalculated = true
            }) {
                Text("Calculer le budget")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal)
            
            if budgetCalculated {
                VStack {
                    if budget > 0 {
                        Text("Budget disponible: \(budget, specifier: "%.2f")")
                            .font(.system(size: 22, weight: .medium, design: .rounded))
                            .foregroundColor(.green)
                    } else {
                        Text("Attention! Vous dépensez plus que ce que vous gagnez.")
                            .font(.system(size: 22, weight: .medium, design: .rounded))
                            .foregroundColor(.red)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(radius: 5)
                )
                .padding(.horizontal)
            }
            
            NavigationLink(destination: BillManagementView(bills: $bills)) {
                Text("Gestion des Factures")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct BudgetPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        let transactionManager = TransactionManager()
        return BudgetPlanningView(transactionManager: transactionManager)
    }
}
