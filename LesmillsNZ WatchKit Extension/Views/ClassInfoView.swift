//
//  ClassInfoView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 27/04/21.
//

import SwiftUI

struct ClassInfoView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var textColor = "#ffffff"
    @State private var iconName = "stopwatch"
    @State private var iconColor = "#25f578"
    @State private var classColor = "#636363"
    @State private var hasStarted = false

    let classInfo: FitnessClass

    private func updateClassState() {
        self.hasStarted = classInfo.hasStarted
        if !classInfo.hasStarted {
            self.textColor = "#ffffff"
            self.iconName = "stopwatch"
            self.iconColor = "#25f578"
            self.classColor = classInfo.colorText
        } else {
            self.textColor = "#636363"
            self.iconName = "flag.slash"
            self.iconColor = "#484848"
            self.classColor = "#636363"
        }
    }

    var body: some View {
        VStack {
            Text(classInfo.nameText)
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundColor(Color(hex: textColor))
            Text("with")
                .font(.system(size: 10))
                .foregroundColor(.gray)
            Text(classInfo.instructorsText)
                .font(.system(size: 12))
                .foregroundColor(Color(hex: textColor))
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(hex: classColor))
                .frame(height: 2)
            Text(classInfo.timeText)
                .font(.system(.caption))
                .strikethrough(hasStarted)
            Text(classInfo.locationText)
                .font(.system(.caption))
                .foregroundColor(Color(hex: textColor))
            Text("\(classInfo.dayText) \(classInfo.dateText) \(classInfo.monthText)")
                .font(.system(.caption))
                .foregroundColor(Color(hex: textColor))
            Image(systemName: iconName)
                .foregroundColor(Color(hex: iconColor))
                .padding(.top, 2)
            Text("\(classInfo.durationText) Minutes")
                .font(.system(size: 14))
                .foregroundColor(Color(hex: iconColor))
        }
        .navigationTitle("Info")
        .onAppear{
            DispatchQueue.main.async {
                self.updateClassState()
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase != .active { return }
            DispatchQueue.main.async {
                self.updateClassState()
            }
        }
    }
}

struct ClassInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ClassInfoView(classInfo: FitnessClass.example)
    }
}
