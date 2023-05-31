//
//  ContentView.swift
//  DailyTasks Watch App
//
//  Created by Jaswitha Reddy G on 4/19/23.
//

import SwiftUI

struct ContentView: View {
    
    // Create an app delegate for a SwiftUI app
    @WKApplicationDelegateAdaptor var applicationDelegate: ApplicationDelegate
    
    @StateObject var dataController = DataController()
    
    var body: some View {
        TabView {
            NavigationStack {
                ItemList(taskController: dataController)
            }
            NavigationStack {
                ProductivityChart()
            }
            NavigationStack {
                Notifications()
            }
        }
        .tabViewStyle(.page)
        .environment(\.managedObjectContext, dataController.mainContext)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

