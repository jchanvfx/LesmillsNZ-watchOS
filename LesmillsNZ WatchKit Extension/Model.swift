//
//  Settings.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 19/02/21.
//

import Foundation


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
