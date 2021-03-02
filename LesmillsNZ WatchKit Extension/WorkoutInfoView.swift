//
//  WorkoutInfoView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 13/02/21.
//

import SwiftUI

struct WorkoutInfoView: View {
    let info: FitnessClass
    var body: some View {
        VStack {
            Text(info.name)
                .font(.system(size: 14))
                .fontWeight(.semibold)
            Text("with")
                .font(.system(size: 10))
                .foregroundColor(.gray)
            Text(info.instructors)
                .font(.system(size: 12))
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(hex:info.color))
                .frame(height: 2)
            Text(info.time)
                .font(.system(.caption))
            Text(info.location)
                .font(.system(.caption))
            Text("\(info.day) \(info.date) \(info.month)")
                .font(.system(.caption))
            if !info.isStarted {
                Image(systemName: "stopwatch")
                    .foregroundColor(.green)
                    .padding(.top, 2)
                Text("\(info.duration) Minutes")
                    .font(.system(size: 14))
                    .foregroundColor(.green)
            } else {
                Image(systemName: "flag.slash")
                    .foregroundColor(.orange)
                    .padding(.top, 2)
                Text("\(info.duration) Minutes")
                    .font(.system(size: 14))
                    .foregroundColor(.orange)
            }
            
        }.navigationTitle("Info")
    }
}

struct WorkoutInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutInfoView(info: FitnessClass.example)
    }
}
