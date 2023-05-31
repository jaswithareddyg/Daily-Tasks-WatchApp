//
//  ApplicationDelegate.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/28/23.
//

import WatchKit
import UserNotifications
import Foundation


class ApplicationDelegate: NSObject, WKApplicationDelegate {
    
    func applicationDidFinishLaunching() {
        print("Did finish launching")
        scheduleBackgroundRefreshTask()
    }
    
    func applicationWillEnterForeground() {
        print("Will enter foreground")
    }
    
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
      
        for task in backgroundTasks {
            switch task {
           
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Do our background task work
                print("⏰ Handling a background task")
                UserDefaults.standard.set(0, forKey: "counter")
                scheduleBackgroundRefreshTask()
                
                // Compare date now to stored data; if its the next day -> reset all the tasks
                
                backgroundTask.setTaskCompletedWithSnapshot(true)
                
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
    
}
