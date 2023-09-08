//
//  MarketDataViewModel.swift
//  WealthWise
//
//  Created by marhuenda joris on 08/09/2023.
//

import Combine
import Foundation

class StockDataViewModel: ObservableObject {
    @Published var stockData: [StockData] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let apiKey = "G1FVP9AW2YRCAK25"
    
    init() {
        fetchStockData()
    }
    
    func fetchStockData() {
        let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=GOOGL&interval=5min&apikey=\(apiKey)")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: AlphaVantageResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.handleAlphaVantageResponse(response)
            })
            .store(in: &cancellables)
    }
    
    private func handleAlphaVantageResponse(_ response: AlphaVantageResponse) {
        guard let timeSeriesData = response.timeSeries else { return }
        
        var stockData: [StockData] = []
        for (key, value) in timeSeriesData {
            if let latestPriceStr = value["4. close"],
               let latestPrice = Double(latestPriceStr),
               let openPriceStr = value["1. open"],
               let openPrice = Double(openPriceStr) {
                
                let change = latestPrice - openPrice
                let changePercentage = (change / openPrice) * 100
                
                let stock = StockData(
                    symbol: response.metaData?.symbol ?? "",
                    companyName: response.metaData?.companyName ?? "",
                    latestPrice: latestPrice,
                    change: change,
                    changePercentage: changePercentage
                )
                stockData.append(stock)
            }
        }
        
        DispatchQueue.main.async {
            self.stockData = stockData
        }
    }

    func clearStockData() {
        self.stockData = []
    }
}
