//
//  ContentView.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 06.07.23.
//

import SwiftUI
import Charts

struct HourlyChartData: Identifiable {
    var hour: Int
    var count: Int
    var id = UUID()
}


struct ContentView: View {
    @ObservedObject var provider: ContentViewProvider
    @State var showSettings = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HourlyStepView(
                    hourlyStepCounts: provider.hourlyStepCounts
                )
                SummaryView(
                    steps: provider.steps,
                    stepGoal: provider.stepGoal,
                    stepProgress: provider.stepProgress
                )
            }
            .padding([.leading, .trailing])
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showSettings, content: {
                Text("Settings")
            })
            .containerBackground(.accent.gradient, for: .navigation)
        }
    }
}

#Preview {
    ContentView(provider: ContentViewProvider())
}
