//
//  TimetableListView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 27/04/21.
//

import SwiftUI

struct TimetableRowView: View {
    let classInfo: FitnessClass

    var body: some View {
        VStack {
            Text(classInfo.nameText)
                .font(.system(size: 12))
                .fontWeight(.semibold)
            Text(classInfo.locationText)
                .font(.system(size: 12))
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(hex: classInfo.colorText))
                .frame(height: 2)
            HStack {
                Text(classInfo.timeText)
                    .padding(.leading, 2)
                Spacer()
                Text("\(classInfo.durationText) mins")
                    .padding(.trailing, 2)
            }
            .font(.system(size: 12))
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
                            if cls.hasStarted {
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
