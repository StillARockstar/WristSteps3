//
//  AppWidget.swift
//  AppWidget
//
//  Created by Michael Schoder on 13.07.23.
//

import WidgetKit
import SwiftUI

struct SummaryWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry

    var body: some View {
        HStack {
            SummaryView(
                steps: 3556,
                stepGoal: 10000,
                stepProgress: 35,
                stepFormatting: .kFormatted
            )
        }
        .padding([.bottom], 8)
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct SummaryWidget: Widget {
    let kind: String = "AppWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SummaryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Summary")
        .configurationDisplayName("Today's steps and goal")
        .supportedFamilies([.accessoryRectangular])
    }
}

#Preview(as: .accessoryCorner) {
    SummaryWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😎")
}
