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
                .colorMultiply(Color.gray)
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
            Text("Reload Timetable")
                .foregroundColor(Color.gray)
                .font(.system(size: 14))
        }
    }
}

struct WeekListView: View {
    @EnvironmentObject var model: Model
    @EnvironmentObject var locations: ClubLocationsModel
    @State var clubLocationText: String = "SELECT LOCATION"

    private func getLocationText() -> String {
        let club = locations.getClubById(id: model.selectedClub)
        if (club != nil) {
            return club!.name
        }
        return "SELECT LOCATION"
    }
    
    var body: some View {
        VStack {
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
                    Button(action: model.makeDataRequest) {
                        ReloadView()
                    }
                } else {
                    Text("Select a club location to display the timetable.")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 14))
                        .padding(5)
                }
                Text("www.lesmills.co.nz")
                    .foregroundColor(Color(hex:"#aa8161"))
                    .font(.system(size: 12))
                    .padding(.top, 5)
            }
        }
        .navigationTitle("Lesmills NZ")
        .onAppear {
            DispatchQueue.main.async {
                self.clubLocationText = self.getLocationText()
            }
        }
    }
}

struct WeekListView_Previews: PreviewProvider {
    static var previews: some View {
        WeekListView()
            .environmentObject(Model(preview: true))
    }
}
