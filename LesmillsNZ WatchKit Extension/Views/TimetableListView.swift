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

    @Environment(\.presentationMode) var presentationMode

    @State private var isVisible: Bool = true
    @State private var scrollToNext: Bool = true

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
                    self.isVisible = true
                    if getCurrentDateId() == dateId {
                        if !self.scrollToNext {
                            return
                        }
                        var scrollToIdx = 0
                        for (idx, cls) in classes.enumerated() {
                            if !cls.isStarted {
                                scrollToIdx = idx
                                break
                            }
                        }
                        // intentional scroll animation here.
                        if scrollToIdx > 3 {
                            proxy.scrollTo(scrollToIdx - 2, anchor: .top)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation {
                                proxy.scrollTo(scrollToIdx, anchor: .top)
                            }
                            self.scrollToNext = false
                        }
                    }
                }
                .onDisappear {
                    self.isVisible = false
                }
            }
        }
        .navigationTitle(formatDateId(dateId, "E dd"))
        .onReceive(
            NotificationCenter.default.publisher(
                for: WKExtension.applicationWillEnterForegroundNotification)) { _ in
            if self.isVisible && dateId < getCurrentDateId() {
                // navigate back if view is outdated when pushed to the foreground.
                presentationMode.wrappedValue.dismiss()
                // note: previous view doesn't seem to update with "onAppear"
                //       must look into this issue..
            }
        }
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
