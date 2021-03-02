//
//  WeekMenuView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 14/02/21.
//

import SwiftUI

struct DisclaimerInfoView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                Text("Disclaimer")
                    .fontWeight(.semibold)
            }
            .padding(.bottom, 2)
            .foregroundColor(Color.yellow)
            .font(.system(size: 12))
            Text(disclaimerText)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.gray)
                .font(.system(size: 12))
        }
    }
}

struct ClubButtonView: View {
    let text: String
    let subText: String
    let systemIcon: String
    let color: Color
    var body: some View {
        VStack(spacing: 2) {
            HStack(spacing: 4) {
                Image(systemName: systemIcon)
                    .foregroundColor(color)
                Text(text)
                    .fontWeight(.semibold)
                    .foregroundColor(color)
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
    
    // default view to navigate to when initialized.
    @State private var pushToView: Int? = 0

    var body: some View {
        VStack {
            if (settings.clubId != "") {
                List {
                    let location = clubLocations.getClubById(
                        id: settings.clubId)!
                    // reload timetable button
                    HStack {
                        Spacer()
                        ClubButtonView(text: location.name,
                                       subText: "Reload Timetable",
                                       systemIcon: "arrow.clockwise",
                                       color: Color.orange
                        )
                        Spacer()
                    }
                    .onTapGesture {
                        fitnessClasses.createRequest()
                    }

                    // fitness classes by day
                    let allClasses = fitnessClasses.allClasses
                    let ids = Array(allClasses.keys).sorted(by: {$0 < $1})
                    if ids.count == 0 {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color(hex: "#380b17"))
                            Text(noClassesText)
                                .foregroundColor(Color(hex: "#f44874"))
                                .font(.system(size: 12))
                                .padding(10)
                        }
                        .padding(.vertical, 10)
                        .listRowBackground(Color.black)
                    } else {
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
                    }
                    
                    // change club location.
                    NavigationLink(destination: LocationsListView()) {
                        HStack{
                            Spacer()
                            ClubButtonView(text: location.name,
                                           subText: "change location",
                                           systemIcon: "location.fill",
                                           color: Color.blue)
                            Spacer()
                        }
                    }

                    // logo image
                    VStack {
                        Image("LmTextLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width:150)
                            .padding(.top, 8)
                            .listRowBackground(Color.black)
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.accentColor)
                            .frame(height: 1)
                    }.listRowBackground(Color.black)
                    
                    // sync info.
                    if fitnessClasses.lastSynced != nil {
                        VStack {
                            Text("Timetable Last Synced:\n\(fitnessClasses.lastSynced!)")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(hex: "#00d6d3"))
                                .font(.system(size: 12))
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color(hex: "#525252"))
                                .frame(height: 1)
                                .padding(.vertical, 5)
                        }.listRowBackground(Color.black)
                    }

                    // disclaimer info.
                    DisclaimerInfoView()
                        .padding(.top, 10)
                        .listRowBackground(Color.black)
                }
            } else {
                // club note set view.
                ScrollView(.vertical) {
                    Image("LmTextLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width:150)
                        .padding(.top, 5)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.accentColor)
                        .frame(height: 1)
                        .padding(.vertical, 5)
                    NavigationLink(destination: LocationsListView()) {
                        ClubButtonView(text: "Club Not Set!",
                                       subText: "select location",
                                       systemIcon: "location.fill",
                                       color: Color.blue)
//                            .buttonStyle(PlainButtonStyle())
                    }
                    // disclaimer info.
                    VStack {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.accentColor)
                            .frame(height: 1)
                            .padding(.bottom, 5)
                        DisclaimerInfoView()
                    }.padding(.top, 5)
                }
            }
        }.navigationTitle("Lesmills NZ")
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView()
    }
}
