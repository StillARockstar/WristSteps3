//
//  ContentView.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 06.07.23.
//

import SwiftUI
import Charts

struct ContentView: View {
    @ObservedObject var provider: ContentViewProvider
    @State var showSettings = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HourlyStepsChart(
                    chartData: HourlyStepsChartData(
                        data: provider
                            .hourlyStepCounts
                            .map({ HourlyStepsBarData(value: $0) })
                    )
                )
                SummaryView(
                    steps: provider.stepCount,
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
    ContentView(
        provider: ContentViewProvider(healthData: PreviewHealthData())
    )
}
