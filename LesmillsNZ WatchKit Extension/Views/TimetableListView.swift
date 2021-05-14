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
    @State private var classColor = "#636363"

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

struct TimetableListView: View {
    @State private var scrollToRow = true

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
                    if !self.scrollToRow { return }
                    DispatchQueue.main.async {
                        // skip scrolling to if date is not today.
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyMMdd"
                        let currentKey = formatter.string(from:Date())
                        let dateKey = classes[0].dateKey!
                        if (currentKey != dateKey) {
                            self.scrollToRow.toggle()
                            return
                        }
                        // scroll to latest class row.
                        for (idx, cls) in classes.enumerated() {
                            if !cls.hasStarted {
                                proxy.scrollTo(idx, anchor: .top)
                                break
                            }
                        }
                        self.scrollToRow.toggle()
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
