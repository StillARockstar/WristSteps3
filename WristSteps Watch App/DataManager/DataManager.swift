//
//  DataManager.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 13.07.23.
//

import Foundation

class DataManager {
    let healthData: HealthData
    
    private init(healthData: HealthData) {
        self.healthData = healthData
    }
    
    static let app: DataManager = {
        DataManager(
            healthData: AppHealthData()
        )
    }()
    
    static let simulator: DataManager = {
        DataManager(
            healthData: PreviewHealthData()
        )
    }()
    
    static let preview: DataManager = {
        DataManager(
            healthData: PreviewHealthData()
        )
    }()
}
