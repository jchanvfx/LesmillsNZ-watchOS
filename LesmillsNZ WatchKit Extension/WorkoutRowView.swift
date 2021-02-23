//
//  WorkoutRowView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 13/02/21.
//

import SwiftUI

struct WorkoutRowView: View {
    let info: FitnessClass
    var body: some View {
        VStack {
            Text(info.name)
                .font(.system(size: 12))
                .fontWeight(.semibold)
            Text(info.location)
                .font(.system(size: 12))
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(hex:info.color))
                .frame(height: 2)
            HStack {
                Text(info.time)
                    .padding(.leading, 2)
                Spacer()
                Text("\(info.duration) mins")
                    .padding(.trailing, 2)
            }.font(.system(size: 12))
        }
    }
}

struct WorkoutRowView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutRowView(info: FitnessClass.example)
    }
}
