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
        VStack(spacing: 20) {
            Text("Alertes et Notifications")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .padding(.top, 20)

            Form {
                Section(header: Text("Alertes de Budget").font(.headline).foregroundColor(.blue)) {
                    Toggle("Alerte quotidienne de dépassement de budget", isOn: $dailyBudgetAlert)
                }
                .listRowBackground(Color.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )

                Section(header: Text("Alertes de Dépenses").font(.headline).foregroundColor(.blue)) {
                    Toggle("Alerte mensuelle de dépenses élevées", isOn: $monthlyExpenseAlert)
                }
                .listRowBackground(Color.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )

                Section(header: Text("Alertes d'Investissement").font(.headline).foregroundColor(.blue)) {
                    Toggle("Alerte des actualités d'investissement", isOn: $investmentNewsAlert)
                }
                .listRowBackground(Color.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
            }
            .listStyle(GroupedListStyle())
            .padding(.horizontal)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.05), Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
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
