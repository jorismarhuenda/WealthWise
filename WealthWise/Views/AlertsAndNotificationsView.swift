//
//  AlertsAndNotificationsView.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI

struct AlertsAndNotificationsView: View {
    @State private var dailyBudgetAlert = false
    @State private var monthlyExpenseAlert = false
    @State private var investmentNewsAlert = false

    var body: some View {
        Form {
            Section(header: Text("Alertes de Budget")) {
                Toggle("Alerte quotidienne de dépassement de budget", isOn: $dailyBudgetAlert)
            }

            Section(header: Text("Alertes de Dépenses")) {
                Toggle("Alerte mensuelle de dépenses élevées", isOn: $monthlyExpenseAlert)
            }

            Section(header: Text("Alertes d'Investissement")) {
                Toggle("Alerte des actualités d'investissement", isOn: $investmentNewsAlert)
            }
        }
        .navigationBarTitle("Alertes et Notifications")
    }
}

struct AlertsAndNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        AlertsAndNotificationsView()
    }
}
