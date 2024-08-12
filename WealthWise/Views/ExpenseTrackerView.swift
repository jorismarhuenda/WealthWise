//
//  ExpenseTrackerView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct ExpenseTrackerView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Suivi des Dépenses")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .padding(.top, 20)

            // Placeholder pour les éléments de suivi des dépenses
            VStack(spacing: 20) {
                // Par exemple, une liste de transactions
                Text("Liste des transactions")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                
                // Par exemple, un graphique de répartition des dépenses
                Text("Graphique de répartition des dépenses")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .padding()
        .navigationBarTitle("Suivi des Dépenses", displayMode: .inline)
    }
}

struct ExpenseTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseTrackerView()
    }
}
