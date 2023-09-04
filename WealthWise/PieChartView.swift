//
//  PieChartView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI

struct PieChartView: View {
    let dataPoints: [ExpenseCategory]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<dataPoints.count) { index in
                    let startAngle: Angle = self.startAngle(for: index)
                    let endAngle: Angle = self.endAngle(for: index)
                    
                    PieSlice(startAngle: startAngle, endAngle: endAngle, dataPoint: dataPoints[index])
                        .foregroundColor(self.sliceColor(index: index))
                        .overlay(PieSliceLabel(dataPoint: dataPoints[index], startAngle: startAngle, endAngle: endAngle))
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.width)
        }
    }
    
    private func startAngle(for index: Int) -> Angle {
        guard index >= 0 && index < dataPoints.count else {
            return .zero
        }
        
        let total = dataPoints.reduce(0) { $0 + $1.amount }
        let normalizedValue = dataPoints[index].amount / total
        
        return .degrees(360 * normalizedValue)
    }
    
    private func endAngle(for index: Int) -> Angle {
        guard index >= 0 && index < dataPoints.count else {
            return .zero
        }
        
        let total = dataPoints.reduce(0) { $0 + $1.amount }
        let normalizedValue = dataPoints[index].amount / total
        
        return .degrees(360 * normalizedValue + startAngle(for: index).degrees)
    }
    
    private func sliceColor(index: Int) -> Color {
        // Vous pouvez personnaliser les couleurs des tranches ici en fonction de l'index
        let colors: [Color] = [.blue, .green, .orange, .red, .purple]
        return colors[index % colors.count]
    }
}


struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(dataPoints: expenseCategories)
    }
}

struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var dataPoint: ExpenseCategory
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        
        return path
    }
}

struct PieSliceLabel: View {
    var dataPoint: ExpenseCategory
    var startAngle: Angle
    var endAngle: Angle
    
    var body: some View {
        VStack {
            Text(dataPoint.name)
                .font(.headline)
            Text("$\(dataPoint.amount, specifier: "%.2f")")
                .font(.subheadline)
        }
        .offset(sliceLabelPosition())
    }
    
    private func sliceLabelPosition() -> CGSize {
        let angleInDegrees = (startAngle.degrees + endAngle.degrees) / 2.0
        let angleInRadians = angleInDegrees * .pi / 180.0 // Conversion en radians
        
        let radius: CGFloat = 100 // Ajustez la distance du label par rapport au centre ici
        
        let x = radius * cos(angleInRadians)
        let y = radius * sin(angleInRadians)
        
        return CGSize(width: x, height: y)
    }
}



