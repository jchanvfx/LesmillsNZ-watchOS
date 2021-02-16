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
    let locations: ClubLocations
    var body: some View {
        List {
//            LocationButton()
        }
    }
}

//struct LocationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationsView()
//    }
//}
