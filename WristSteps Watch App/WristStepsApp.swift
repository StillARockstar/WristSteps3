//
//  WristStepsApp.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 06.07.23.
//

import SwiftUI
import WatchKit

@main
struct WristSteps_Watch_AppApp: App {
    @WKApplicationDelegateAdaptor(ExtensionDelegate.self) var extensionDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(provider: ContentViewProvider(healthData: extensionDelegate.healthData))
        }
    }
}

class ExtensionDelegate: NSObject, WKApplicationDelegate {
    #if TARGET_WATCH
    let healthData = AppHealthData()
    #else
    let healthData = PreviewHealthData()
    #endif
    
    func applicationWillEnterForeground() {
        healthData.reloadData(completion: { })
    }
}
