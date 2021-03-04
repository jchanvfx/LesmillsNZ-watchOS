//
//  Settings.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 19/02/21.
//

import Foundation

let disclaimerText = """
This app is NOT officially part of Les Mills I just made it \
to conveniently display the timetable on my watch without using \
the iPhone app.\n
\u{2665} Group Fitness\n#LesMillsNZ
"""

let noClassesText = """
No data avaliable please try reloading (\u{2191}) or change \
club location (\u{2193}).
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
