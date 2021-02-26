//
//  Settings.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 19/02/21.
//

import Foundation

let disclaimerNote = "Disclaimer:\nThis watch app is not officially part of Les Mills I made this app so I can conveniently display class times without the need of taking out my phone at the gym."

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
