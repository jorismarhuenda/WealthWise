//
//  AlertsAndNotificationsView.swift
//  WealthWise
//
//  Created by marhuenda joris on 04/09/2023.
//

import SwiftUI
import UserNotifications

struct AlertsAndNotificationsView: View {
    @AppStorage("DailyBudgetAlert") private var dailyBudgetAlert = false
    @AppStorage("MonthlyExpenseAlert") private var monthlyExpenseAlert = false
    @AppStorage("InvestmentNewsAlert") private var investmentNewsAlert = false

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
        .onAppear {
            requestNotificationAuthorization()
        }
    }

    private func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                // Autorisé à envoyer des notifications
            } else {
                // Refusé d'envoyer des notifications
            }
        }
    }
}

struct AlertsAndNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        AlertsAndNotificationsView()
    }
}
