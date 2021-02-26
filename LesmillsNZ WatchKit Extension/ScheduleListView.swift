//
//  WeekMenuView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 14/02/21.
//

import SwiftUI

struct ClubButtonView: View {
    let text: String
    let subText: String
    var body: some View {
        VStack(spacing: 2) {
            HStack(spacing: 4) {
                Image(systemName: "location.fill")
                    .foregroundColor(.blue)
                Text(text)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            .padding(.leading, -16)
            Text(subText)
                .foregroundColor(.gray)
        }
        .font(.system(size: 12))
        .padding(.bottom, 1)
    }
}

struct ScheduleListView: View {
    @EnvironmentObject var settings: UserSettings
    @EnvironmentObject var fitnessClasses: FitnessClasses
    @EnvironmentObject var clubLocations: ClubLocations
    
    // default timetable when initialized.
    @State private var pushToView: Int? = 0

    var body: some View {
        VStack {
            if (settings.clubId != "") {
                List {
                    // club location.
                    NavigationLink(destination: LocationsListView()) {
                        let location = clubLocations.getClubById(
                            id: settings.clubId)!
                        HStack{
                            Spacer()
                            ClubButtonView(text: location.name,
                                           subText: "change location")
                            Spacer()
                        }
                    }
                    // days
                    let allClasses = fitnessClasses.allClasses
                    let ids = Array(allClasses.keys).sorted(by: {$0 < $1})
                    ForEach(Array(zip(ids.indices, ids)), id: \.0) { x, id in
                        let classes = allClasses[id]!
                        NavigationLink(
                            destination: TimetableListView(dateId: id, classes: classes),
                            tag: x, selection: $pushToView
                        ) {
                            HStack {
                                Spacer()
                                Text(formatDayTextFromId(id: id))
                                Spacer()
                            }
                        }
                    }
                    // logo image
                    VStack {
                        Image("LmTextLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width:150)
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.accentColor)
                            .frame(height: 1)
                        if fitnessClasses.lastSynced != nil {
                            Text("Timetable Last Synced:\n\(fitnessClasses.lastSynced!)")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(hex: "#00d6d3"))
                                .font(.system(size: 12))
                        }
                    }.listRowBackground(Color.black)
                    // data reload
                    Button(action: {fitnessClasses.createRequest()}) {
                        HStack {
                            Spacer()
                            Text("Reload")
                            Spacer()
                        }
                    }
                }
            } else {
                // no club set.
                Spacer()
                Image("LmTextLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:150)
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.accentColor)
                    .frame(height: 1)
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                NavigationLink(destination: LocationsListView()) {
                    ClubButtonView(text: "Club Not Set!",
                                   subText: "select location")
//                        .buttonStyle(PlainButtonStyle())
                }
                Spacer()
            }
        }.navigationTitle("Lesmills NZ")
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView()
    }
}
