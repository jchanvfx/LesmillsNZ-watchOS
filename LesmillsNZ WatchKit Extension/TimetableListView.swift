//
//  ContentView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 13/02/21.
//

import SwiftUI

struct TimetableListView: View {
    let dateId: String
    let classes: [FitnessClass]

    @State private var jumpTo = true

    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                ForEach(0 ..< classes.count) { idx in
                    NavigationLink(destination: WorkoutInfoView(info: classes[idx])) {
                        WorkoutRowView(info: classes[idx])
                    }
                    .frame(height: 58)
                    .id(idx)
                }
                .onAppear {
                    if getCurrentDateId() == dateId {
                        if !jumpTo {
                            return
                        }
                        var scrollToIdx = 0
                        for (idx, cls) in classes.enumerated() {
                            if !cls.isStarted {
                                scrollToIdx = idx
                                break
                            }
                        }
                        // minor scrolling animation :P.
                        if scrollToIdx > 3 {
                            proxy.scrollTo(scrollToIdx - 2, anchor: .top)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation {
                                proxy.scrollTo(scrollToIdx, anchor: .top)
                            }
                            jumpTo.toggle()
                        }
                    }
                }
            }
        }
        .navigationTitle(formatDateTitleFromId(id: dateId))
    }
}

struct TimetableListView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableListView(
            dateId: "170221",
            classes: [
                FitnessClass.example,
                FitnessClass.example,
                FitnessClass.example,
                FitnessClass.example,
            ])
    }
}
