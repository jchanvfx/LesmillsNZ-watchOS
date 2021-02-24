//
//  WeekMenuView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 14/02/21.
//

import SwiftUI

struct CurrentClubView: View {
    let text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Image(systemName: "location.fill")
                    .foregroundColor(.blue)
                Text(text)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            Text("change location")
                .foregroundColor(.gray)
                .padding(.leading, 18)
        }
        .font(.system(size: 12))
        .padding(.leading, 5)
        .padding(.bottom, 1)
    }
}

struct DaysMenuView: View {
    @EnvironmentObject var settings: UserSettings
    @EnvironmentObject var fitnessClasses: FitnessClasses
    @EnvironmentObject var clubLocations: ClubLocations
    
    var body: some View {
        VStack (alignment: .leading) {
            if (settings.clubId != "") {
                NavigationLink(destination:LocationsMenuView()) {
                    let location = clubLocations.getClubById(
                        id: settings.clubId)!
                    CurrentClubView(text: location.name)
                }
                .buttonStyle(PlainButtonStyle())
                List {
                    let allClasses = fitnessClasses.allClasses
                    let ids = Array(allClasses.keys).sorted(by: {$0 < $1})
                    ForEach(ids, id: \.self) { id in
                        NavigationLink(
                            destination: TimetableView(
                                id: id, workouts: allClasses[id]!)
                        ) {
                            Text(formatDayTextFromId(id:id))
                                .padding(.horizontal)
                        }
                    }
                }
            } else {
                NavigationLink(destination:LocationsMenuView()) {
                    CurrentClubView(text: "No Club Selected")
                }
                .buttonStyle(PlainButtonStyle())
                Text("Please set a club location to display timetable.")
                    .font(.caption2)
                    .padding(.top, 20)
                Spacer()
            }
        }.navigationTitle("Lesmills NZ")
    }
}

struct DaysMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DaysMenuView()
    }
}
