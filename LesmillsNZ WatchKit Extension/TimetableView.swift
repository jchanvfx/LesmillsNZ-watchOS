//
//  ContentView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 13/02/21.
//

import SwiftUI

struct TimetableView: View {
    let title: String
    var workouts: [FitnessClass]
    var body: some View {
        List {
            ForEach (0 ..< workouts.count) { idx in
                NavigationLink(destination: WorkoutInfoView(
                    info: workouts[idx]
                )){WorkoutRowView(info: workouts[idx])}
            }  
        }.navigationTitle(title)
    }
}

struct TimetableView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableView(title: "Day dd/mm",
                      workouts: [FitnessClass.example])
    }
}
