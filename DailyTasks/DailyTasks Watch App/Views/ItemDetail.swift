//
//  ItemDetail.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/19/23.
//

/*
A view to display and edit the details of a list item.
*/


import SwiftUI
import Foundation
import CoreData

struct ItemDetail: View {
    @ObservedObject var taskController: DataController
    @State private var title: String
    @Binding var isCompleted: Bool

    var task: Item {
        didSet {
            title = task.title ?? ""
            isCompleted = task.isComplete
        }
    }
    
    init(taskController: DataController, task: Item, title: String, isCompleted: Binding<Bool>) {
        self.taskController = taskController
        self.task = task
        _title = State(initialValue: title)
        _isCompleted = isCompleted
    }

    var body: some View {
        Form {
            Section("List Item") {
                TextField("Item", text: $title, prompt: Text("List Item"))
            }

            Section("Created On") {
                Text("\(task.createdDate ?? Date(), formatter: dateFormatter)")
            }

            Toggle(isOn: $isCompleted) {
                Text("Completed")
            }

            ShareLink(item: title,
                      subject: Text("Please help!"),
                      message: Text("(I need some help finishing this.)"),
                      preview: SharePreview("\(title)"))
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .onDisappear {
            updateTaskInCoreData()
        }
    }

    private func updateTaskInCoreData() {
        taskController.updateTask(task: task, title: title, isComplete: isCompleted)
    }
}


struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        let taskController = DataController()
        let task = Item(context: taskController.mainContext)
        task.title = "Sample Task"
        task.isComplete = false
        
        // Create a separate Boolean binding for the isComplete property
        let isCompleteBinding = Binding<Bool>(
            get: { task.isComplete },
            set: { newValue in
                // Update the task's isComplete property when the binding value changes
                task.isComplete = newValue
                try? taskController.mainContext.save() // Save the changes to Core Data
            }
        )
        
        return ItemDetail(taskController: taskController, task: task, title: task.title ?? "", isCompleted: isCompleteBinding)
    }
}



private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()
