//
//  Settings.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 19/02/21.
//

import Foundation

let disclaimerText = """
This app is NOT officially part of Les Mills I made this app \
to conveniently display the timetable on my watch and for the \
love of group fitness\n
\u{2665} #lesmillsnz
"""

let noClassesText = """
No data avaliable for the selected club please try reloading \
(\u{2191}) or change club location (\u{2193}).
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
