//
//  WeekMenuView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 14/02/21.
//

import SwiftUI

struct CurrentClubView: View {
    let location: ClubLocation
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "location.fill")
                .foregroundColor(.blue)
            Text(location.name)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
        }
        .font(.system(size: 12))
        .padding(.leading, 5)
        .padding(.bottom, 5)
    }
}

struct DaysMenuView: View {
    @EnvironmentObject var settings: UserSettings
    @EnvironmentObject var fitnessClasses: FitnessClasses
    @EnvironmentObject var clubLocations: ClubLocations
    
    var body: some View {
        VStack (alignment: .leading) {
            NavigationLink(destination:LocationsMenuView()) {
                CurrentClubView(
                    location: clubLocations.getClubById(id: settings.clubId)!)
            }
            .buttonStyle(PlainButtonStyle())
            List {
                let allClasses = fitnessClasses.allClasses
                let ids = Array(allClasses.keys).sorted(by: {$0 < $1})
                ForEach(ids, id: \.self) { id in
                    NavigationLink(
                        destination: TimetableView(
                            title: formatDateTitleFromId(id: id),
                            workouts: allClasses[id]!)
                    ) {
                        Text(formatDayTextFromId(id:id))
                            .padding(.horizontal)
                    }
                }
            }
        }.navigationTitle("Lesmills NZ")
    }
}

struct DaysMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DaysMenuView()
    }
}
