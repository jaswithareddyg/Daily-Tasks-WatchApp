//
//  NotificationController.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/28/23.
//

import WatchKit
import SwiftUI
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {
   
    var message: String!
    var emoji: String!
    var date: String!
    
    override var body: NotificationView {
        return NotificationView(message: message, emoji: emoji, date: formatDate(date))
    }
    
    ///
    // MARK: - Lifecycle
    //
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func didReceive(_ notification: UNNotification) {
        print("🐛 \(#function) - \(notification)")

        // Increment a counter (for fun)
        let currentCount: Int = UserDefaults.standard.integer(forKey: "counter")
        print("🐛 \(#function) - counter:\(currentCount)")
        UserDefaults.standard.set(currentCount + 1, forKey: "counter")

        // Parse out the content
        let content = notification.request.content
        message = content.body
        
        let validRange = 0...2
        let emojis = ["😀","👍","☝️"]
        
        if let imageNumber = content.userInfo["imageNumber"] as? Int,
            validRange ~= imageNumber {
            emoji = emojis[imageNumber]
            date = Date().description
        } else {
            let num = Int.random(in: validRange)
            emoji = emojis[num]
            date = Date().description
        }
    }
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z" // Assuming the date is in this format

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
            return dateFormatter.string(from: date)
        }

        return ""
    }
}
