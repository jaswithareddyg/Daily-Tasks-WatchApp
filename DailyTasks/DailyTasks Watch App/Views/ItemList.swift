//
//  ItemList.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/19/23.
//

/*
A list of all the items.
*/

import SwiftUI

struct ItemList: View {
    @ObservedObject var taskController: DataController
    
    var body: some View {
        List(taskController.tasks) { task in
            ItemRow(taskController: taskController, task: task)
        }
        .toolbar {
            AddItemLink(taskController: taskController)
        }
        .navigationTitle("Daily Tasks")
    }
}

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        let taskController = DataController()
        
        let task1 = Item(context: taskController.mainContext)
        task1.title = "Task 1"
        task1.isComplete = false
        
        let task2 = Item(context: taskController.mainContext)
        task2.title = "Task 2"
        task2.isComplete = true
        
        taskController.tasks = [task1, task2]
        
        return ItemList(taskController: taskController)
    }
}

