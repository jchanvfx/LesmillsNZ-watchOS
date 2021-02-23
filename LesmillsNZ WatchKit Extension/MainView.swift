//
//  MainView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 19/02/21.
//

import SwiftUI

struct MainView: View {
    @StateObject var settings = UserSettings()
    @StateObject var clubLocations = ClubLocations()
    @StateObject var fitnessClasses = FitnessClasses()
    @State var isLoadingVisible = true
    
    var body: some View {
        if isLoadingVisible {
            LoadingView()
                .onAppear {
                    loadTimetable()
                }
        } else {
            NavigationView {
                DaysMenuView()
            }
            .environmentObject(fitnessClasses)
            .environmentObject(clubLocations)
            .environmentObject(settings)
            .transition(.move(edge: .bottom))
        }
    }
    
    func loadTimetable() {
        createTimetableRequest(
            clubID: settings.clubId,
            completionBlock: processTimtableData)
    }

    func processTimtableData(requestData:[String: [FitnessClass]]) {
        DispatchQueue.main.async {
            fitnessClasses.allClasses = requestData
        }
        withAnimation {
            isLoadingVisible.toggle()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
