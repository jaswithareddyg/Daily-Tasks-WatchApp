//
//  TaskModel.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/25/23.
//

import Foundation
import CoreData

extension Item {
    @discardableResult convenience init(id: UUID = UUID(), title: String, createdDate: Date = Date(), isComplete: Bool, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = id
        self.title = title
        self.createdDate = createdDate
        self.isComplete = isComplete
    }
}
