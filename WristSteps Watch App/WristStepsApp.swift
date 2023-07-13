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
            ContentView(provider: ContentViewProvider(dataManager: extensionDelegate.dataManager))
        }
    }
}

class ExtensionDelegate: NSObject, WKApplicationDelegate {
    #if TARGET_WATCH
    let dataManager = DataManager.app
    #else
    let dataManager = DataManager.simulator
    #endif
    
    func applicationWillEnterForeground() {
        dataManager.healthData.reloadData(completion: { })
    }
}
