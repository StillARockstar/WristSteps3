//
//  ContentViewProvider.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 09.07.23.
//

import Foundation
import Combine

class ContentViewProvider: ObservableObject {
    let steps = 3665
    let stepGoal = 10000
    let stepProgress = 35.0
    let hourlyStepCounts = [75, 0, 0, 0, 0, 0, 100, 500, 1100, 700, 400, 350, 600, 650, 470, 400, 600, 900, 930, 700, 600, 400, 300, 200]
}
