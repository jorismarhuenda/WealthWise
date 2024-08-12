//
//  MarketNewsAndUpdatesView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct MarketNewsAndUpdatesView: View {
    @ObservedObject var viewModel = StockDataViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.stockData) { stock in
                        StockCardView(stock: stock)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 20)
            }
            .navigationBarTitle("Marchés Boursiers en Direct", displayMode: .inline)
        }
        .onAppear {
            viewModel.clearStockData()
            viewModel.fetchStockData()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct StockCardView: View {
    var stock: StockData

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(stock.companyName)
                .font(.headline)
                .foregroundColor(.blue)

            Text("Symbole: \(stock.symbol)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("Prix: \(stock.latestPrice, specifier: "%.2f") USD")
                .font(.subheadline)
                .foregroundColor(.primary)

            Text("Changement: \(stock.change, specifier: "%.2f") (\(stock.changePercentage, specifier: "%.2f")%)")
                .font(.subheadline)
                .foregroundColor(stock.change >= 0 ? .green : .red)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}

struct MarketNewsAndUpdatesView_Previews: PreviewProvider {
    static var previews: some View {
        MarketNewsAndUpdatesView()
    }
}
