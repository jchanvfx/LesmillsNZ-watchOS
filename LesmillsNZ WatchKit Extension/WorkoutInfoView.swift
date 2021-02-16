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
            Text(info.name.uppercased())
                .font(.title3)
            Text("with")
                .font(.system(size: 10))
                .foregroundColor(.gray)
            Text(info.instructor1)
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
            HStack(spacing: 1) {
                Image(systemName: "timer")
                Text("\(info.duration)")
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
        WorkoutInfoView(info: FitnessClass.example)
    }
}
