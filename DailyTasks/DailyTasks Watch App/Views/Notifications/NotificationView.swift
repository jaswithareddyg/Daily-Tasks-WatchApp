//
//  NotificationView.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/28/23.
//

import SwiftUI

struct NotificationView: View {

    let message: String
    let emoji: String
    let date: String
    let counter: Int = UserDefaults.standard.integer(forKey: "counter")
    
    var body: some View {
        ScrollView {
            Text(message)
                .font(.headline)
            Text(emoji)
                .font(.system(size:100))
            Text("Keep checking off those tasks!")
                .font(. system(size:15))
                .multilineTextAlignment(.center)
            Text("\(counter)")
            Text(formatDate(date))
                .multilineTextAlignment(.center)
            
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

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(
            message: "You can do it!",
            emoji: "👍",
            date: Date().description
        )
    }
}
