//
//  AddItemList.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/19/23.
//

/*
A text field link to add an item to the item list model.
*/


import SwiftUI

struct AddItemLink: View {
    @ObservedObject var taskController: DataController
    @State private var newItemTitle: String = ""
    
    var body: some View {
        VStack {
            TextField("New Item", text: $newItemTitle)
                .padding(.horizontal)
            
            Button(action: {
                addItem()
                newItemTitle = ""
            }) {
                Label("Add", systemImage: "plus.circle.fill")
            }
            .disabled(newItemTitle.isEmpty)
            .padding()
            
            Spacer()
                .frame(height: 5.0)
        }
    }
    
    private func addItem() {
        taskController.createTask(
            id: UUID(),
            title: newItemTitle,
            createdDate: Date(),
            isComplete: false
        )
    }
}

struct AddItemLink_Previews: PreviewProvider {
    static var previews: some View {
        AddItemLink(taskController: DataController())
    }
}

