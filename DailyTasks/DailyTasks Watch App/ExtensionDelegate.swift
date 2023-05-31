//
//  ExtensionDelegate.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/29/23.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        for task in backgroundTasks {
            if let refreshTask = task as? WKApplicationRefreshBackgroundTask {
                handleComplicationBackgroundRefresh(refreshTask)
            }
        }
    }

    private func handleComplicationBackgroundRefresh(_ task: WKApplicationRefreshBackgroundTask) {
        // Perform any necessary background work here to update your complication data
        
        // Once the background work is completed, call the task.setTaskCompleted() method
        task.setTaskCompletedWithSnapshot(false)
    }
}

