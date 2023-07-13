//
//  ContentViewProvider.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 09.07.23.
//

import Foundation
import Combine

class ContentViewProvider: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = Set()
    private let healthData: HealthData
    private(set) var stepCount: Int
    private(set) var hourlyStepCounts: [Int?]
    let stepGoal = 10000
    var stepProgress: Double {
        return Double(stepCount) / Double(stepGoal) * 100
    }
    
    init(healthData: HealthData) {
        self.healthData = healthData
        stepCount = healthData.stepCount
        hourlyStepCounts = healthData.hourlyStepCounts
        
        healthData.$hourlyStepCounts
            .debounce(for: .milliseconds(50), scheduler: RunLoop.current)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValues in
                self?.hourlyStepCounts = newValues
            }
            .store(in: &subscriptions)
        healthData.$stepCount
            .debounce(for: .milliseconds(50), scheduler: RunLoop.current)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.stepCount = newValue
            }
            .store(in: &subscriptions)
    }
}
