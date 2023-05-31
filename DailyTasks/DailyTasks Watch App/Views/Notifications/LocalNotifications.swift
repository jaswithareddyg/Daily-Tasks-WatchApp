//
//  LocalNotifications.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/28/23.
//

import Foundation
import UserNotifications


final class LocalNotifications: NSObject {
    
    static let categoryIdentifier = "DailyTask"
    private let actionIdentifier = "viewAction"
    
    override init() {
        super.init()
        
        Task {
            do {
                try await self.register()
                try await self.schedule()
            } catch {
                print("⌚️ local notification: \(error.localizedDescription)")
            }
        }
    }
    
    /// Register to receive notifications and the action buttons
    func register() async throws {
        let current = UNUserNotificationCenter.current()
        try await current.requestAuthorization(options: [.alert, .badge, .sound])
        
        // Help with debugging
        //current.removeDeliveredNotifications(withIdentifiers: ["",""])
        current.removeAllPendingNotificationRequests()
        
        let action = UNNotificationAction(
            identifier: self.actionIdentifier,
            title: "Let's check it out!",
            options: .foreground)
        
        let category = UNNotificationCategory(
            identifier: Self.categoryIdentifier,
            actions: [action],
            intentIdentifiers: [])
        
        current.setNotificationCategories([category])
        current.delegate = self
    }
    
    
    // Schedule a local notification
    func schedule() async throws {
        
        let current = UNUserNotificationCenter.current()
        let settings = await current.notificationSettings()
        guard settings.alertSetting == .enabled else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Daily Tasks"
        content.subtitle = "Local Notification"
        content.body = "Good habits start today."
        content.categoryIdentifier = Self.categoryIdentifier
        content.userInfo = ["extra_data": "customize this however you want."]
        
        //        let components = DateComponents(minute: 1)
        //        let trigger = UNCalendarNotificationTrigger(
        //            dateMatching: components,
        //            repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        try await current.add(request)
        
        print("🐛 \(#function) - Local Notification Added: \(request)")
    }
}


extension LocalNotifications: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.list, .badge, .sound]
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Handle notification after a user action. Note that dismissing the notification is also a user action
        print("🐛 \(#function)")
        print("🐛 response: \(response)")
        
        // Get the user info from the notification
        let userInfo = response.notification.request.content
        print("🐛 content - \(userInfo)")
        
        completionHandler()
    }
    
}
