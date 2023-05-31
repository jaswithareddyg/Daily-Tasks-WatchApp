//
//  ItemRow.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/19/23.
//

/*
A view to display a list item as a row in the list.
*/

import SwiftUI
import Foundation
import CoreData

struct ItemRow: View {
    @ObservedObject var taskController: DataController
    @State private var title: String
    @State private var isCompleted: Bool
    @State private var showDetail = false
    
    var task: Item {
        didSet {
            title = task.title ?? ""
            isCompleted = task.isComplete
        }
    }
    
    init(taskController: DataController, task: Item) {
        self.taskController = taskController
        self.task = task
        _title = State(initialValue: task.title ?? "")
        _isCompleted = State(initialValue: task.isComplete)
    }
    
    var body: some View {
        Button {
            showDetail = true
        } label: {
            HStack {
                Text(title)
                    .strikethrough(isCompleted)
                Spacer()
                Image(systemName: "checkmark").opacity(isCompleted ? 100 : 0)
            }
        }
        .sheet(isPresented: $showDetail) {
            ItemDetail(taskController: taskController, task: task, title: title, isCompleted: $isCompleted)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            showDetail = false
                        }
                    }
                }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        let taskController = DataController()
        let task = Item(context: taskController.mainContext)
        task.title = "Build an app!"
        task.isComplete = false
        
        return ItemRow(taskController: taskController, task: task)
    }
}
