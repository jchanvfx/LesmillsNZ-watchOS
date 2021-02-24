//
//  LocationsView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 16/02/21.
//

import SwiftUI

struct LocationButton: View {
    let location: ClubLocation
    var body: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.system(.caption))
            Text(location.address)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
    }
}

struct LocationsMenuView: View {
    @EnvironmentObject var settings: UserSettings
    @EnvironmentObject var clubLocations: ClubLocations
    @EnvironmentObject var fitnessClasses: FitnessClasses
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List {
            ForEach(0 ..< clubLocations.count) { idx in
                let location = clubLocations.locations[idx]
                LocationButton(location: location)
                    .onTapGesture {
                        // update selected club id in settings.
                        settings.setClubId(id: location.id)
                        // make new timetable request.
                        fitnessClasses.clubId = location.id
                        fitnessClasses.createRequest()
                        // pop the current view.
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
        .navigationTitle("Locations")
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsMenuView()
    }
}
