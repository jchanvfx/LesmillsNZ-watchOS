//
//  LesmillsNZApp.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 13/02/21.
//

import SwiftUI

@main
struct LesmillsNZApp: App {
    @StateObject var settings = UserSettings()
    @StateObject var clubLocations = ClubLocations()
    @StateObject var fitnessClasses = FitnessClasses()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(fitnessClasses)
                .environmentObject(clubLocations)
                .environmentObject(settings)
                .onAppear {
                    fitnessClasses.clubId = settings.clubId
                    fitnessClasses.createRequest()
                }
        }
    }
}
