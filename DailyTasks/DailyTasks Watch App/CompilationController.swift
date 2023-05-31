//
//  CompilationController.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/19/23.
//

import ClockKit
import CoreData

class ComplicationController: NSObject, CLKComplicationDataSource {

    private let managedObjectContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
        super.init()
    }

    // MARK: - Complication Configuration
    
    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(
                identifier: "complication",
                displayName: "WatchTaskListSample",
                supportedFamilies: CLKComplicationFamily.allCases
            )
            /// Add multiple complication support here with more descriptors.
        ]
        
        /// Call the handler with the currently supported complication descriptors.
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        /// Do any necessary work to support these newly shared complication descriptors.
    }
    
    // MARK: - Timeline Configuration
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        /// Call the handler with the last entry date you can currently provide or nil if you can't support future timelines.
        handler(nil)
    }
    
    func getPrivacyBehavior(
        for complication: CLKComplication,
        withHandler handler: @escaping (CLKComplicationPrivacyBehavior)
        -> Void) {
        /// Call the handler with your desired behavior when the device is in a locked state.
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(
        for complication: CLKComplication,
        withHandler handler: @escaping (CLKComplicationTimelineEntry?)
        -> Void) {
        let uncompletedTasksCount = fetchUncompletedTasksCount()
        let template = createComplicationTemplate(uncompletedTasksCount: uncompletedTasksCount)
        let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
        handler(entry)
    }
    
    func getTimelineEntries(
        for complication: CLKComplication,
        after date: Date,
        limit: Int,
        withHandler handler: @escaping ([CLKComplicationTimelineEntry]?)
        -> Void) {
        /// Call the handler with the timeline entries after the given date.
        handler(nil)
    }
    
    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        /// The system calls this method once per supported complication, and caches the results.
        let uncompletedTasksCount = 5 // Replace with your logic to get the sample count
        let template = createComplicationTemplate(uncompletedTasksCount: uncompletedTasksCount)
        handler(template)
    }
    
    // MARK: - Helper Methods
    
    // Fetches the count of uncompleted tasks from CoreData
    private func fetchUncompletedTasksCount() -> Int {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let completedPredicate = NSPredicate(format: "isComplete == NO")
        request.predicate = completedPredicate
        
        do {
            let uncompletedTasks = try managedObjectContext.fetch(request)
            return uncompletedTasks.count
        } catch {
            print("Error fetching tasks: \(error)")
            return 0
        }
    }
    
    // Creates a complication template with the uncompleted tasks count
    private func createComplicationTemplate(uncompletedTasksCount: Int) -> CLKComplicationTemplate {
        let textProvider = CLKSimpleTextProvider(text: "\(uncompletedTasksCount)")
        let gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .green, fillFraction: Float(uncompletedTasksCount) / 10.0)
        
        return CLKComplicationTemplateGraphicRectangularTextGauge(
            headerTextProvider: textProvider,
            body1TextProvider: CLKSimpleTextProvider(text: "Count: 1"),
            gaugeProvider: gaugeProvider
        )
    }

}

