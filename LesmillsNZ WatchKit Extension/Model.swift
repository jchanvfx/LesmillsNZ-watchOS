//
//  Settings.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 19/02/21.
//

import Foundation

let disclaimerText = """
This app is NOT officially part of Les Mills I made this app \
to help conveniently display class timetable without my iPhone \
and for the love of the group fitness classes.
"""

let noClassesText = """
No classes avaliable for the selected club please try reloading \
timetable (\u{2191}) above or change club location (\u{2193}) below.
"""

class UserSettings: ObservableObject {
    @Published var clubId: String
    
    init() {
        // read the app settings here.
        self.clubId = UserDefaults.standard.string(forKey: "clubId") ?? ""
    }

    func setClubId(id:String) {
        self.clubId = id
        UserDefaults.standard.set(self.clubId, forKey: "clubId")
    }
}
