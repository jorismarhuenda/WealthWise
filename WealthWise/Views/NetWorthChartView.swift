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
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.blue.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                // Calculate maxValue and minValue outside of Path to simplify expressions
                let maxValue = dataPoints.map { $0.netWorth }.max() ?? 0
                let minValue = dataPoints.map { $0.netWorth }.min() ?? 0
                let valueRange = maxValue - minValue
                let xInterval = geometry.size.width / CGFloat(dataPoints.count - 1)
                let yInterval = geometry.size.height / CGFloat(valueRange)

                // Path for the chart line
                Path { path in
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
                
                // Fill the area under the line
                Path { path in
                    path.move(to: CGPoint(x: 0, y: geometry.size.height))
                    
                    for (index, dataPoint) in dataPoints.enumerated() {
                        let x = CGFloat(index) * xInterval
                        let y = CGFloat(dataPoint.netWorth - minValue) * yInterval
                        path.addLine(to: CGPoint(x: x, y: geometry.size.height - y))
                    }
                    
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
                
                // Adding points for each data point
                ForEach(0..<dataPoints.count, id: \.self) { index in
                    let x = CGFloat(index) * xInterval
                    let y = CGFloat(dataPoints[index].netWorth - minValue) * yInterval
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 8, height: 8)
                        .position(x: x, y: geometry.size.height - y)
                        .shadow(radius: 1)
                }
            }
        }
        .frame(height: 250)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 10)
        )
    }
}

struct NetWorthChartView_Previews: PreviewProvider {
    static var previews: some View {
        NetWorthChartView(dataPoints: netWorthDataPoints)
    }
}
