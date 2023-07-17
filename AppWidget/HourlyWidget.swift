//
//  HourlyWidget.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 17.07.23.
//

import WidgetKit
import SwiftUI

struct HourlyWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Today 3556")
                    .font(.footnote)
                    .foregroundStyle(.accent.gradient)
                    .padding(0)
                Spacer()
            }
            HourlyStepsChart(chartData: HourlyStepsChartData(data: [
                HourlyStepsBarData(value: nil),
                HourlyStepsBarData(value: nil),
                HourlyStepsBarData(value: nil),
                HourlyStepsBarData(value: nil),
                HourlyStepsBarData(value: nil),
                HourlyStepsBarData(value: nil),
                HourlyStepsBarData(value: nil),
                HourlyStepsBarData(value: nil),
                HourlyStepsBarData(value: nil),
                HourlyStepsBarData(value: nil),
                HourlyStepsBarData(value: nil),
                HourlyStepsBarData(value: 00),
                HourlyStepsBarData(value: 01),
                HourlyStepsBarData(value: 02),
                HourlyStepsBarData(value: 03),
                HourlyStepsBarData(value: 04),
                HourlyStepsBarData(value: 05),
                HourlyStepsBarData(value: 06),
                HourlyStepsBarData(value: 07),
                HourlyStepsBarData(value: 08),
                HourlyStepsBarData(value: 09),
                HourlyStepsBarData(value: 10),
                HourlyStepsBarData(value: 11),
                HourlyStepsBarData(value: 12)
            ]))
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct HourlyWidget: Widget {
    let kind: String = "HourlyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HourlyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Hourly Chart")
        .configurationDisplayName("Chart of today steps")
        .supportedFamilies([.accessoryRectangular])
    }
}

#Preview(as: .accessoryRectangular) {
    HourlyWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😎")
}
