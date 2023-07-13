//
//  HealthData.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 13.07.23.
//

import Foundation
import Combine

class HealthData {
    @Published var stepCount: Int = 0
    @Published var hourlyStepCounts: [Int?] = [Int?](repeating: nil, count: 24)
    private var subscriptions: Set<AnyCancellable> = Set()
    
    init() {
        self.$hourlyStepCounts.sink(receiveValue: { hourlyStepCounts in
            self.stepCount = hourlyStepCounts.compactMap({$0}).reduce(0, +)
        })
        .store(in: &subscriptions)
    }
    
    func reloadData(completion: @escaping (() -> Void)) {
        fatalError("Do not use reloadData() of HealthData class")
    }
}
