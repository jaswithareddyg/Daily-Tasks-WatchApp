//
//  IntegerFormatStyle.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/19/23.
//

import Foundation

/// `ProductivityChart` uses this type to format the values on the y-axis.
struct IntegerFormatStyle: FormatStyle {
    func format(_ value: Double) -> String {
        " \(Int(value))"
    }
}

