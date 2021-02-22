//
//  WeekMenuView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 14/02/21.
//

import SwiftUI

struct CurrentClubView: View {
    let name: String
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "location.fill")
                .foregroundColor(.blue)
            Text(name)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
        }
        .font(.system(size: 12))
        .padding(.leading, 5)
        .padding(.bottom, 5)
    }
}

struct DaysMenuView: View {
    @EnvironmentObject var fitnessClasses: FitnessClasses
    
    var body: some View {
        VStack (alignment: .leading) {
            let clubs = ClubLocations()
            NavigationLink(
                destination: LocationsView(clubLocations: clubs)) {
                CurrentClubView(name: clubs.selected.name)
            }.buttonStyle(PlainButtonStyle())
            List {
                ForEach(0 ..< fitnessClasses.ids.count) { idx in
                    let id = fitnessClasses.ids[idx]
                    let text = fitnessClasses.getDayText(id:id)
                    let title = fitnessClasses.getDayTitle(id: id)
                    let workouts = fitnessClasses.allWorkouts[id]
                    NavigationLink(
                        destination: TimetableView(
                            title: title, workouts: workouts!)) {
                        Text(text)
                            .padding(.horizontal)
                    }
                }
            }.navigationTitle("Lesmills NZ")
        }
    }
}

struct DaysMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DaysMenuView()
    }
}
