//
//  DailyTasksApp.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/19/23.
//

import SwiftUI

@main
struct DailyTasksApp: App {

    // Create an app delegate for a SwiftUI app
    @WKApplicationDelegateAdaptor var applicationDelegate: ApplicationDelegate
    
    // Capture the scene phase of the application
    @Environment(\.scenePhase) var scenePhase
    
    // Setup notifications
    let local = LocalNotifications()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active {
                print("Active")
            } else if newPhase == .background {
                print("Background")
            }
        }
        
        WKNotificationScene(
            controller: NotificationController.self,
            category: LocalNotifications.categoryIdentifier
        )
    }
}


func scheduleBackgroundRefreshTask() {
    print("Scheduling a background task")
    
    // Apple says, "If there is a complication on the watch face, the app should get at least four
    // updates an hour." So calculate a target date 15 minutes in the future.
    
    // let targetDate = Date().addingTimeInterval(15 * 60.0)
    let targetDate = Date().addingTimeInterval(1 * 30.0) // cheating in simulator
    
    // Schedule the background refresh task
    WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: targetDate,
                                                   userInfo: nil) { (error) in
        guard error == nil else {
            print("An error occurred while scheduling a background refresh task: \(error!.localizedDescription)")
            return
        }
        print("⏰ Task scheduled: \(targetDate)")
    }
    
}
