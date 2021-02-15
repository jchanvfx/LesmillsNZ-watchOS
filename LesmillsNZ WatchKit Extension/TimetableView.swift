//
//  ContentView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 13/02/21.
//

import SwiftUI

struct TimetableView: View {
    var body: some View {
        List {
            NavigationLink(destination: WorkoutInfoView(
                title:"BODYPUMP",
                name: "Test User",
                color: "#FF0000",
                date: "Sun 13 Feb",
                time: "10:00am",
                location: "Studio1",
                duration: 60
            )){
                WorkoutRowView(
                    title:"BODYPUMP",
                    name: "Test User",
                    color: "#FF0000",
                    date: "Sun 13 Feb",
                    time: "10:00am",
                    location: "Studio1",
                    duration: 60
                )
            }
        }.navigationTitle("Sat 13/02")
    }
}

struct TimetableView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableView()
    }
}
