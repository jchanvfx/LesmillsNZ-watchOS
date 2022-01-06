//
//  WeekListView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 27/04/21.
//

import SwiftUI

struct LogoLocationView: View {
    let text: String
    var body: some View {
        VStack{
            Image("LmTextLogo")
                .resizable()
                .scaledToFit()
                .colorMultiply(Color(hex: "#e3e3e3"))
            Text(text)
                .font(.system(size: 12))
                .padding(0)
                .foregroundColor(Color(hex:"#aa8161"))
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 30)
    }
}

struct ReloadView: View {
    var body: some View {
        HStack {
            Image(systemName: "arrow.uturn.right.circle.fill")
                .foregroundColor(Color(hex:"#aa8161"))
            Text("Reload")
                .foregroundColor(Color(hex:"#d1d1d1"))
                .font(.system(size: 14))
        }
        .offset(x: -5)
    }
}

struct WeekListView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var model: Model
    @EnvironmentObject var locations: ClubLocationsModel

    @State private var clubLocationText: String = "SELECT LOCATION"

    private func getLocationText() -> String {
        let club = locations.getClubById(id: model.selectedClub)
        guard club != nil else { return "SELECT LOCATION" }
        return club!.name
    }

    var body: some View {
//        VStack {
            ScrollView {
                //Location label
                NavigationLink(destination: ClubLocationsView()) {
                    LogoLocationView(text:clubLocationText)
                }
                
                if (model.selectedClub != "") {
                    // Weekday buttons
                    let keyLabels = model.getButtonLabels()
                    ForEach(0 ..< keyLabels.count) { idx in
                        let classes = model.getClassesByDate(keyLabels[idx].0)
                        NavigationLink(destination: TimetableListView(classes:classes)) {
                            Text(keyLabels[idx].1)
                        }
                        .id(idx)
                    }
                    // Reload button
                    Button {
                        model.makeDataRequest()
                    } label: {
                        ReloadView()
                    }

                    // Error message display.
                    if (model.requestError != nil) {
                        Text(model.requestError!)
                            .foregroundColor(Color(hex:"#ed4e4e"))
                            .font(.system(size: 12))
                            .padding()
                    }

                    // No data message.
                    if (keyLabels.count == 0) {
                        Text("No timetable data avaliable please try reloading.")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 12))
                            .padding()
                    }
                } else {
                    Text("Select a club location to display the timetable.")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 14))
                        .padding()
                }
                Text("www.lesmills.co.nz")
                    .foregroundColor(Color(hex:"#aa8161"))
                    .font(.system(size: 12))
                    .padding([.top, .bottom], 5)
            }
//            .refreshable {
//                await model.reloadTimetable()
//            }
//        }
        .navigationTitle("Lesmills NZ")
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarHidden(true)
        .onAppear {
            DispatchQueue.main.async {
                self.clubLocationText = self.getLocationText()
            }
        }
        .onChange(of: scenePhase) { newPhase in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                if newPhase != .active { return }
                // if last timetable request is 48 hours old then make
                // a new request.
                guard let lastSynced = self.model.lastSyncedDate else {
                    return
                }
                let timeDiff = Date() - lastSynced
                if (timeDiff.hour! >= 48) {
                    self.model.makeDataRequest()
                }
            }
        }
    }
}

struct WeekListView_Previews: PreviewProvider {
    static var previews: some View {
        WeekListView()
            .environmentObject(Model.preview)
    }
}
