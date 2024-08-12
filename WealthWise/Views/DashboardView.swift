//
//  DashboardView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.presentationMode) var presentationMode
    let transactionManager = TransactionManager()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 25) {
                NavigationLink(destination: BudgetPlanningView(transactionManager: transactionManager)) {
                    DashboardListItem(title: "Planification Budgétaire", image: "chart.pie.fill")
                }
                
                NavigationLink(destination: WealthManagementView()) {
                    DashboardListItem(title: "Gestion de Patrimoine", image: "banknote.fill")
                }
                
                NavigationLink(destination: InvestmentAssistanceView()) {
                    DashboardListItem(title: "Aide à l'Investissement", image: "arrow.up.arrow.down.circle.fill")
                }
                
                NavigationLink(destination: TransactionsView(transactionManager: transactionManager)) {
                    DashboardListItem(title: "Transactions", image: "creditcard.fill")
                }
                
                NavigationLink(destination: MarketNewsAndUpdatesView()) {
                    DashboardListItem(title: "Marchés Boursiers en Direct", image: "newspaper.fill")
                }
                
                NavigationLink(destination: RetirementTrackerView()) {
                    DashboardListItem(title: "Suivi de la Retraite", image: "chart.bar.fill")
                }
            }
            .padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.blue.opacity(0.3)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Tableau de Bord", displayMode: .inline)
    }
}

struct DashboardListItem: View {
    let title: String
    let image: String

    var body: some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.white)
                .padding()
                .background(
                    Circle()
                        .fill(Color.blue.opacity(0.6))
                        .shadow(radius: 5)
                )
            
            Text(title)
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .foregroundColor(.blue)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
        }
        .padding()
        .background(
            VisualEffectBlur(blurStyle: .systemMaterial)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.blue.opacity(0.7), lineWidth: 1)
        )
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
