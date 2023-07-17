//
//  AppWidgets.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 17.07.23.
//

import WidgetKit
import SwiftUI

@main
struct AppWidgets: WidgetBundle {
   var body: some Widget {
       SummaryWidget()
       HourlyWidget()
   }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😎")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entryDate = Date()
        let entry = SimpleEntry(date: entryDate, emoji: "😀")

        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}
