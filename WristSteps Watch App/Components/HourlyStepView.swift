//
//  HourlyStepView.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 09.07.23.
//

import SwiftUI
import Charts

struct HourlyStepView: View {
    private let hourlyChartData: [HourlyChartData]
    private let minStepValue: Int
    
    
    init (hourlyStepCounts: [Int]) {
        var hourlyChartData = [HourlyChartData]()
        for (index, steps) in hourlyStepCounts.enumerated() {
            hourlyChartData.append(HourlyChartData(hour: index, count: steps))
        }
        self.hourlyChartData = hourlyChartData
        self.minStepValue = hourlyStepCounts.filter({ $0 > 0}).min() ?? 0
    }
    
    var body: some View {
        Chart(hourlyChartData) { data in
            BarMark(
                x: .value("hour", data.hour),
                y: .value("count", max(data.count, minStepValue)),
                width: 4
            )
            .cornerRadius(2)
            .foregroundStyle(.accent.gradient)
            .opacity(data.count >= minStepValue ? 1.0 : 0.5)
        }
        .chartYAxis {
            AxisMarks(values: [0]) {
                AxisGridLine()
            }
        }
        .chartXAxis {
            AxisMarks(values: [0, 6, 12, 18, 23])
        }
    }
}

#Preview {
    HourlyStepView(hourlyStepCounts: [75, 0, 0, 0, 0, 0, 100, 500, 1100, 700, 400, 350, 600, 650, 470, 400, 600, 900, 930, 700, 600, 400, 300, 200])
}
