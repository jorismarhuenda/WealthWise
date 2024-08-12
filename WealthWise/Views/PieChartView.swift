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
                        .fill(self.sliceColor(index: index))
                        .overlay(
                            PieSliceLabel(dataPoint: dataPoints[index], startAngle: startAngle, endAngle: endAngle)
                                .foregroundColor(.white)
                        )
                        .shadow(radius: 5)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.width)
            .background(
                Circle()
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            )
        }
    }

    private func startAngle(for index: Int) -> Angle {
        guard index >= 0 && index < dataPoints.count else {
            return .zero
        }

        let total = dataPoints.reduce(0) { $0 + $1.amount }
        let startDegree = dataPoints.prefix(index).reduce(0) { $0 + $1.amount } / total

        return .degrees(360 * startDegree)
    }

    private func endAngle(for index: Int) -> Angle {
        guard index >= 0 && index < dataPoints.count else {
            return .zero
        }

        let total = dataPoints.reduce(0) { $0 + $1.amount }
        let endDegree = dataPoints.prefix(index + 1).reduce(0) { $0 + $1.amount } / total

        return .degrees(360 * endDegree)
    }

    private func sliceColor(index: Int) -> Color {
        // Palette de couleurs modernisée
        let colors: [Color] = [.blue, .green, .orange, .purple, .pink, .yellow]
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
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .shadow(radius: 1)
            Text("$\(dataPoint.amount, specifier: "%.2f")")
                .font(.system(size: 12, weight: .regular, design: .rounded))
                .shadow(radius: 1)
        }
        .padding(5)
        .background(Color.black.opacity(0.5))
        .cornerRadius(5)
        .offset(sliceLabelPosition())
    }
    
    private func sliceLabelPosition() -> CGSize {
        let angleInDegrees = (startAngle.degrees + endAngle.degrees) / 2.0
        let angleInRadians = angleInDegrees * .pi / 180.0
        
        let radius: CGFloat = 70 // Distance ajustée du label par rapport au centre
        
        let x = radius * cos(angleInRadians)
        let y = radius * sin(angleInRadians)
        
        return CGSize(width: x, height: y)
    }
}
