//
//  WorkoutInfoView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 13/02/21.
//

import SwiftUI

struct WorkoutInfoView: View {
    let title: String
    let name: String
    let color: String
    let date: String
    let time: String
    let location: String
    let duration: Int
    var body: some View {
        VStack {
            Text(title)
                .font(.title3)
            Text("with")
                .font(.system(size: 10))
                .foregroundColor(.gray)
            Text(name)
                .font(.system(size: 12))
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(hex:color))
                .frame(height: 2)
            Text(time)
                .font(.system(.caption))
            Text(location)
                .font(.system(.caption))
            HStack(spacing: 1) {
                Image(systemName: "timer")
                Text("\(duration)")
            }
            .font(.system(.caption))
            .foregroundColor(.green)
            Text("minutes")
                .font(.system(size: 12))
                .foregroundColor(.green)
                
        }.navigationTitle("Classes")
    }
}

struct WorkoutInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutInfoView(
            title:"BODYPUMP",
            name: "Test User",
            color: "#FF0000",
            date: "Sun 13 Feb",
            time: "10:00am",
            location: "Studio1",
            duration: 60
        )
    }
}
