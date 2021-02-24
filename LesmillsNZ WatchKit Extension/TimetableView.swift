//
//  ContentView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 13/02/21.
//

import SwiftUI

struct TimetableView: View {
    let id: String
    let workouts: [FitnessClass]

    @EnvironmentObject var fitnessClasses: FitnessClasses
    
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(workouts, id: \.self) { cls in
                    NavigationLink(destination: WorkoutInfoView(info: cls)) {
                        WorkoutRowView(info: cls)
                    }
                }
            }.onAppear {
                let nextClass = fitnessClasses.getNextClass(id: id)
                if nextClass != nil {
                    withAnimation {
                        proxy.scrollTo(nextClass!, anchor: .top)
                    }
                }
            }
        }
        .navigationTitle(formatDateTitleFromId(id: id))
    }
}

struct TimetableView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableView(
            id: "170221",
            workouts: [
                FitnessClass.example,
                FitnessClass.example,
                FitnessClass.example,
                FitnessClass.example,
            ])
    }
}
