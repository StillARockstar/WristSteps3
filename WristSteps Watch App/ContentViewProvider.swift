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
    private let dataManager: DataManager
    @Published private(set) var stepCount: Int
    @Published private(set) var hourlyStepCounts: [Int?]
    @Published private(set) var stepGoal = 10000
    var stepProgress: Double {
        return Double(stepCount) / Double(stepGoal) * 100
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        stepCount = dataManager.healthData.stepCount
        hourlyStepCounts = dataManager.healthData.hourlyStepCounts
        
        dataManager.healthData.$hourlyStepCounts
            .debounce(for: .milliseconds(50), scheduler: RunLoop.current)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValues in
                self?.hourlyStepCounts = newValues
            }
            .store(in: &subscriptions)
        dataManager.healthData.$stepCount
            .debounce(for: .milliseconds(50), scheduler: RunLoop.current)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.stepCount = newValue
            }
            .store(in: &subscriptions)
    }
}
