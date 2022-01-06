//
//  ClubLocationsView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 28/04/21.
//

import SwiftUI

struct ClubLocationRowView: View {
    let location: ClubLocationModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.system(.caption2))
                Text(location.address)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding(.leading, 6)
            Spacer()
        }
    }
}

struct ClubLocationsView: View {
    @EnvironmentObject var model: Model
    @EnvironmentObject var clubLocations: ClubLocationsModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                ForEach(0 ..< clubLocations.count) { idx in
                    let location = clubLocations.locations[idx]
                    Button(action: {
                        // update the selected club in model.
                        model.setSelectedClub(clubID: location.id)
                        model.makeDataRequest()
                        // pop the current view.
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        ClubLocationRowView(location: location)
                    }.id(idx)
                }
                .onAppear{
                    DispatchQueue.main.async {
                        // scroll to the selected club row.
                        let locations = self.clubLocations.locations
                        for (idx, club) in locations.enumerated() {
                            if (club.id == model.selectedClub) {
                                proxy.scrollTo(idx, anchor: .bottom)
                                break
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Locations")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ClubLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClubLocationsView()
                .environmentObject(ClubLocationsModel(preview: true))
                .environmentObject(Model())
        }
    }
}
