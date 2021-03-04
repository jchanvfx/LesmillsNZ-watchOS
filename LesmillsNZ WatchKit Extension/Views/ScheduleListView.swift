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
            Text("Disclaimer")
                .fontWeight(.semibold)
                .padding(.bottom, 2)
            Text(disclaimerText)
        }
        .multilineTextAlignment(.center)
        .font(.system(size: 12))
        .foregroundColor(Color.gray)
        .padding(5)
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
    
    @State private var dateIds: [String] = []
    @State private var isVisible: Bool = true
    @State private var pushToView: Int? = 0

    var body: some View {
        VStack {
            if (settings.clubId != "") {
                List {
                    let location = clubLocations.getClubById(
                        id: settings.clubId)!
                    // reload button
                    HStack {
                        Spacer()
                        ClubButtonView(text: "Reload",
                                       subText: location.name,
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
                    if dateIds.count == 0 {
                        VStack {
                            if fitnessClasses.requestError != nil {
                                Text(fitnessClasses.requestError!)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(hex: "#f44874"))
                                    .padding(.bottom, 5)
                                    .listRowBackground(Color.black)
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color(hex: "#380b17"))
                                Text(noClassesText)
                                    .foregroundColor(Color(hex: "#f44874"))
                                    .font(.system(size: 12))
                                    .padding(10)
                            }
                        }
                        .padding(.vertical, 10)
                        .listRowBackground(Color.black)
                    } else {
                        ForEach(Array(zip(dateIds.indices, dateIds)), id: \.0) { x, id in
                            let classes = allClasses[id]!
                            NavigationLink(
                                destination: TimetableListView(dateId: id, classes: classes),
                                tag: x, selection: $pushToView
                            ) {
                                HStack {
                                    Spacer()
                                    Text(formatDateId(id, "E dd MMM"))
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    // change location.
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

                        // sync info.
                        if fitnessClasses.lastSynced != nil {
                            Text("Data Last Synced:\n\(fitnessClasses.lastSynced!)")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(hex: "#00d6d3"))
                                .font(.system(size: 12))
                        }
                    }.listRowBackground(Color.black)
//                    // disclaimer info.
//                    DisclaimerInfoView()
//                        .padding(.top, 10)
//                        .listRowBackground(Color.black)
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
        }
        .navigationTitle("Lesmills NZ")
        .onAppear {
            self.isVisible = true
            // update date id list when viewed.
            self.dateIds = fitnessClasses.dateIds
        }
        .onDisappear {
            self.isVisible = false
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: WKExtension.applicationWillEnterForegroundNotification)) { _ in
            if self.isVisible {
                // update date id list when pushed to the foreground.
                self.dateIds = fitnessClasses.dateIds
            }
        }
//        .onReceive(
//            NotificationCenter.default.publisher(
//                for: WKExtension.applicationWillResignActiveNotification)) { _ in
//            if self.isVisible {
//
//            }
//        }
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView()
    }
}
