//
//  TimetableListView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 27/04/21.
//

import SwiftUI

struct TimetableRowView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var textColor = "#ffffff"
    @State private var classColor = "#ffffff"
    
    let classInfo: FitnessClass

    private func updateClassState() {
        if !classInfo.hasStarted {
            self.textColor = "#ffffff"
            self.classColor = classInfo.colorText
        } else {
            self.textColor = "#636363"
            self.classColor = "#636363"
        }
    }

    var body: some View {
        VStack {
            Text(classInfo.nameText)
                .foregroundColor(Color(hex:textColor))
                .font(.system(size: 12))
                .fontWeight(.semibold)
            Text(classInfo.locationText)
                .foregroundColor(Color(hex:textColor))
                .font(.system(size: 12))
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(hex: classColor))
                .frame(height: 2)
            HStack {
                Text(classInfo.timeText)
                    .foregroundColor(Color(hex:textColor))
                    .padding(.leading, 2)
                Spacer()
                Text("\(classInfo.durationText) mins")
                    .foregroundColor(Color(hex:textColor))
                    .padding(.trailing, 2)
            }
            .font(.system(size: 12))
        }
        .onAppear {
            self.updateClassState()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                self.updateClassState()
            }
        }
    }
}

struct TimetableListView: View {
    let classes: [FitnessClass]

    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                ForEach(0 ..< classes.count) { idx in
                    NavigationLink(destination: ClassInfoView(classInfo: classes[idx])) {
                        TimetableRowView(classInfo: classes[idx])
                    }
                    .frame(height: 58)
                    .id(idx)
                }
                .onAppear{
                    DispatchQueue.main.async {
                        // scroll to latest class row.
                        for (idx, cls) in classes.enumerated() {
                            if !cls.hasStarted {
                                proxy.scrollTo(idx, anchor: .top)
                                break
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("\(classes[0].dayText) (\(classes[0].dateText))")
    }
}

struct TimetableListView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableListView(classes: [FitnessClass.example])
    }
}
