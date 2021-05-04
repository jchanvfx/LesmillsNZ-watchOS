//
//  LesmillsNZApp.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 27/04/21.
//

import SwiftUI

@main
struct LesmillsNZApp: App {
    @StateObject var model = Model()
    @StateObject var clubLocations = ClubLocationsModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .environmentObject(clubLocations)
                .onAppear{
                    // make initial timetable request.
                    model.makeDataRequest()
                }
        }
    }
}
