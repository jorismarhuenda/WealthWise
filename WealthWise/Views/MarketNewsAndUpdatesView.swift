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
            List(viewModel.stockData) { stock in
                VStack {
                    Text(stock.companyName)
                        .font(.headline)
                    
                    Text("Symbole: \(stock.symbol)")
                        .font(.subheadline)
                    
                    Text("Prix: \(stock.latestPrice, specifier: "%.2f") USD")
                        .font(.subheadline)
                    
                    Text("Changement: \(stock.change, specifier: "%.2f") (\(stock.changePercentage, specifier: "%.2f")%)")
                        .font(.subheadline)
                        .foregroundColor(stock.change >= 0 ? .green : .red)
                }
            }
            .navigationBarTitle("Marchés Boursiers en Direct")
        }
        .onAppear {
            viewModel.clearStockData()
            viewModel.fetchStockData()
        }
    }
}

struct MarketNewsAndUpdatesView_Previews: PreviewProvider {
    static var previews: some View {
        MarketNewsAndUpdatesView()
    }
}
