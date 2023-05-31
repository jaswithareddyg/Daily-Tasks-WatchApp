//
//  Notifications.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/19/23.
//

import Foundation
import UserNotifications
import SwiftUI

struct Notifications: View {
    
    @State private var isSwitchOn = false
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    
    private let localNotifications = LocalNotifications()
    
    var body: some View {
        Form{
            Section {
                Toggle("Notifications", isOn: $isSwitchOn)
            }
            Section {
                Text("Selected Time: \(formattedTime(selectedHour, selectedMinute))")
                    .font(.headline)
            }
            .disabled(!isSwitchOn)
            
            Section("Hours:"){
                Stepper(value: $selectedHour, in: 0...23, label: {
                    Text("\(selectedHour)")
                })
            }
            .disabled(!isSwitchOn)
            
            Section("Minutes"){
                Stepper(value: $selectedMinute, in: 0...59, label: {
                    Text("\(selectedMinute)")
                })
            }
            .disabled(!isSwitchOn)
            
            Section {
                Button(action: {
                    registerForNotifications()
                }) {
                    Text("Register for Notifications")
                }
            }
        }
    }

    private func formattedTime(_ hour: Int, _ minute: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date()) ?? Date()
        return formatter.string(from: date)
    }
    
    private func registerForNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Failed to request authorization for notifications: \(error.localizedDescription)")
                return
            }

            if granted {
                scheduleNotification()
            } else {
                print("User denied authorization for notifications")
            }
        }
    }

    private func scheduleNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Daily Tasks"
        notificationContent.body = "Good habits start today."

        let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: selectedHour, minute: selectedMinute), repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}

struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        Notifications()
    }
}
