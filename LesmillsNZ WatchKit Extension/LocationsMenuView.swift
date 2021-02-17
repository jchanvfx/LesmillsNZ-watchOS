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

struct LocationsView: View {
    let clubLocations: ClubLocations
    var body: some View {
        List {
            ForEach(0 ..< clubLocations.count) {
                let location = self.clubLocations.locations[$0]
                LocationButton(location: location)
            }
        }
        .navigationTitle("Location")
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView(clubLocations:ClubLocations())
    }
}
