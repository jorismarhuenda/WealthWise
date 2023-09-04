//
//  NetWorthChartView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct NetWorthChartView: View {
    let dataPoints: [NetWorthDataPoint]
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let maxValue = dataPoints.map { $0.netWorth }.max() ?? 0
                let minValue = dataPoints.map { $0.netWorth }.min() ?? 0
                let valueRange = maxValue - minValue
                let xInterval = geometry.size.width / CGFloat(dataPoints.count - 1)
                let yInterval = geometry.size.height / CGFloat(valueRange)
                
                for (index, dataPoint) in dataPoints.enumerated() {
                    let x = CGFloat(index) * xInterval
                    let y = CGFloat(dataPoint.netWorth - minValue) * yInterval
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: geometry.size.height - y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: geometry.size.height - y))
                    }
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
        .frame(height: 200) // Ajustez la hauteur du graphique en conséquence
    }
}

struct NetWorthChartView_Previews: PreviewProvider {
    static var previews: some View {
        NetWorthChartView(dataPoints: netWorthDataPoints)
   
    }
}
