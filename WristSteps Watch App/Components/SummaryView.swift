//
//  SummaryView.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 09.07.23.
//

import SwiftUI

enum SummaryViewStepFormatting {
    case regular
    case kFormatted
}

struct SummaryView: View {
    @State private var stepFormatting: SummaryViewStepFormatting
    let steps: Int
    let stepGoal: Int
    let stepProgress: Double
    
    init(steps: Int, stepGoal: Int, stepProgress: Double, stepFormatting: SummaryViewStepFormatting = .regular) {
        self.stepFormatting = stepFormatting
        self.steps = steps
        self.stepGoal = stepGoal
        self.stepProgress = stepProgress
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(stepFormatting == .regular
                     ? "\(steps)"
                     : steps.kFormattedString
                )
                    .font(.largeTitle)
                    .foregroundStyle(.accent.gradient)
                Text("/")
                    .font(.largeTitle)
                    .foregroundStyle(.accent.gradient)
                VStack(alignment: .leading) {
                    Text(stepGoal.kFormattedString)
                        .fontWeight(.bold)
                    Text("steps")
                        .fontWeight(.bold)
                }
                .foregroundStyle(.accent.gradient)
                Spacer()
            }
            HStack {
                Text("Today \(stepProgress, specifier: "%.0f")%")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                Spacer()
            }
        }
    }
}

#Preview("Regular Formatted") {
    SummaryView(steps: 5555, stepGoal: 10000, stepProgress: 35)
}
#Preview("k Formatted") {
    SummaryView(steps: 5555, stepGoal: 10000, stepProgress: 35, stepFormatting: .kFormatted)
}
