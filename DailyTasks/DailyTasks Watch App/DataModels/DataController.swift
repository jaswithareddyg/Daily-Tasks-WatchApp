//
//  DataController.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/25/23.
//

import Foundation
import CoreData
import Combine

class DataController: ObservableObject {

   // MARK: - Properties
   // all computed properties have to return something!
    @Published var tasks: [Item] = []
    
    let mainContext: NSManagedObjectContext
    
    init() {
        mainContext = CoreDataStack.shared.mainContext
        getTasks()
   }
   
    
   func saveToPersistentStore() {
       let moc = CoreDataStack.shared.mainContext
       do {
           try moc.save()
           getTasks()
        
       } catch {
           NSLog("Error saving managed object context: \(error)")
       }
   }
   
   func getTasks() {
       let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
       let moc = CoreDataStack.shared.mainContext

       do {
           tasks = try moc.fetch(fetchRequest)
            
       } catch {
           NSLog("Error fetching tasks: \(error)")

       }
   }

   // MARK: - CRUD Methods

   // Create
    func createTask(id: UUID, title: String, createdDate: Date, isComplete: Bool) {
        let moc = CoreDataStack.shared.mainContext
        _ = Item(id: id, title: title, createdDate: createdDate, isComplete: isComplete, context: moc)
        saveToPersistentStore()
    }

   // Read

   // Update
    func updateTask(task: Item, title: String, isComplete: Bool) {
        task.title = title
        task.isComplete = isComplete
        saveToPersistentStore()
    }
    
   // Delete
}
