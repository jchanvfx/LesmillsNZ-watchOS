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
    
    var body: some View {
        VStack (alignment: .leading) {
            let clubs = ClubLocations()
            NavigationLink(
                destination: LocationsView(clubLocations: clubs)) {
                CurrentClubView(name: clubs.selected.name)
            }.buttonStyle(PlainButtonStyle())
            List {
                NavigationLink(
                    destination: TimetableView(title: "Sun 15/02")) {
                    Text("Sun 15 Feb")
                        .padding(.horizontal)
                }
                NavigationLink(
                    destination: TimetableView(title: "Mon 16/02")) {
                    Text("Mon 16 Feb")
                        .padding(.horizontal)
                }
                NavigationLink(
                    destination: TimetableView(title: "Tue 17/02")) {
                    Text("Tue 17 Feb")
                        .padding(.horizontal)
                }
                NavigationLink(
                    destination: TimetableView(title: "Wed 18/02")) {
                    Text("Wed 18 Feb")
                        .padding(.horizontal)
                }
                NavigationLink(
                    destination: TimetableView(title: "Thur 19/02")) {
                    Text("Thu 19 Feb")
                        .padding(.leading, 10)
                }
                NavigationLink(
                    destination: TimetableView(title: "Fri 20/02")) {
                    Text("Fri 20 Feb")
                        .padding(.leading, 10)
                }
                NavigationLink(
                    destination: TimetableView(title: "Sat 21/02")) {
                    Text("Sat 21 Feb")
                        .padding(.leading, 10)
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
