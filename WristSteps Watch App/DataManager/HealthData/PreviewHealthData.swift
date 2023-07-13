//
//  PreviewHealthData.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 13.07.23.
//

import Foundation

class PreviewHealthData: HealthData {
    
    override init() {
        super.init()
        hourlyStepCounts = [75, 0, 0, 0, 0, 0, 100, 500, 1100, 700, 400, 350, 600, 650, 470, 400, 600, 900, 930, 700, 600, 400, 300, 200]
    }
    
    override func reloadData(completion: @escaping (() -> Void)) {
        completion()
    }
}
