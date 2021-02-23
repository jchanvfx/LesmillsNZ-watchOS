//
//  Settings.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 19/02/21.
//

import Foundation


class UserSettings: ObservableObject {
    @Published var clubId:String
    
    init() {
        // note to self read the app settings file here
        clubId = "04"
    }

    func setClubId(id:String) {
        self.clubId = id
    }
}
