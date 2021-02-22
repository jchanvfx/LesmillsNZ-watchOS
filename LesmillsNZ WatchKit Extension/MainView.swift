//
//  MainView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 19/02/21.
//

import SwiftUI

struct MainView: View {
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
            .transition(.move(edge: .bottom))
        }
    }
    
    func loadTimetable() {
        createTimetableRequest(
            clubID: "04", completionBlock: processTimtableData)
    }

    func processTimtableData(requestData:[String: [FitnessClass]]) {
        fitnessClasses.ids = Array(requestData.keys).sorted(by: {$0 < $1})
        fitnessClasses.allWorkouts = requestData
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
