//
//  ClassInfoView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 27/04/21.
//

import SwiftUI

struct ClassInfoView: View {
    @State private var iconName = "stopwatch"
    @State private var iconColor = "#25f578"

    let classInfo: FitnessClass
    
    var body: some View {
        VStack {
            Text(classInfo.nameText)
                .font(.system(size: 14))
                .fontWeight(.semibold)
            Text("with")
                .font(.system(size: 10))
                .foregroundColor(.gray)
            Text(classInfo.instructorsText)
                .font(.system(size: 12))
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(hex: classInfo.colorText))
                .frame(height: 2)
            Text(classInfo.timeText)
                .font(.system(.caption))
            Text(classInfo.locationText)
                .font(.system(.caption))
            Text("\(classInfo.dayText) \(classInfo.dateText) \(classInfo.monthText)")
                .font(.system(.caption))
            Image(systemName: iconName)
                .foregroundColor(Color(hex: iconColor))
                .padding(.top, 2)
            Text("\(classInfo.durationText) Minutes")
                .font(.system(size: 14))
                .foregroundColor(Color(hex: iconColor))
        }
        .navigationTitle("Info")
        .onAppear{
            if classInfo.hasStarted {
                self.iconName = "flag.slash"
                self.iconColor = "#484848"
            }
        }
    }
}

struct ClassInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ClassInfoView(classInfo: FitnessClass.example)
    }
}
