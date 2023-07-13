//
//  AppHealthData.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 13.07.23.
//

import Foundation
import CoreMotion

class AppHealthData: HealthData {
    private let pedometer = CMPedometer()
    
    override init() {
        super.init()
    }
    
    override func reloadData(completion: @escaping (() -> Void)) {
        var completedUpdates = 0
        var hourlyStepCountsCache = self.hourlyStepCounts
        for i in 0..<self.hourlyStepCounts.count {
            loadHour(hour: i, completion: { [weak self] hourlyStepCount in
                completedUpdates += 1
                hourlyStepCountsCache[i] = hourlyStepCount
                if completedUpdates == self?.hourlyStepCounts.count ?? 0 - 1 {
                    self?.hourlyStepCounts = hourlyStepCountsCache
                    completion()
                }
            })
        }
    }
    
    private func loadHour(hour: Int, completion: @escaping ((Int?) -> Void)) {
        let calendar = Calendar(identifier: .gregorian)
        let nowDate = Date()
        let nowDateComponent = calendar.dateComponents([.year, .month, .day], from: nowDate)

        var startDateComponents = DateComponents()
        startDateComponents.year = nowDateComponent.year
        startDateComponents.month = nowDateComponent.month
        startDateComponents.day = nowDateComponent.day
        startDateComponents.hour = hour
        startDateComponents.minute = 0
        startDateComponents.second = 0
        let startDate = calendar.date(from: startDateComponents) ?? nowDate
        if startDate > nowDate {
            completion(nil)
            return
        }

        var endDateComponents = DateComponents()
        endDateComponents.year = nowDateComponent.year
        endDateComponents.month = nowDateComponent.month
        endDateComponents.day = nowDateComponent.day
        endDateComponents.hour = hour
        endDateComponents.minute = 59
        endDateComponents.second = 59
        let endDate: Date
        if calendar.date(from: endDateComponents) ?? nowDate < nowDate {
            endDate = calendar.date(from: endDateComponents) ?? nowDate
        } else {
            endDate = nowDate
        }

        pedometer.queryPedometerData(
            from: startDate,
            to: endDate,
            withHandler: { pedometerData, error in
                guard let pedometerData = pedometerData else {
                    completion(nil)
                    return
                }
                completion(pedometerData.numberOfSteps.intValue)
        })
    }
}
