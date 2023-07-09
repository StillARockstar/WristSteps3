//
//  SummaryView.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 09.07.23.
//

import SwiftUI

struct SummaryView: View {
    let steps: Int
    let stepGoal: Int
    let stepProgress: Double
    
    var body: some View {
        VStack {
            HStack {
                Text("\(steps)")
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

#Preview {
    SummaryView(steps: 5555, stepGoal: 10000, stepProgress: 35)
}
