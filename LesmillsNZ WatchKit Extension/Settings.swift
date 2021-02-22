//
//  Settings.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 19/02/21.
//

import Foundation


class UserSettings: ObservableObject {

    var selectedClub:String
    
    init() {
        // note to self read the app settings file here
        selectedClub = "04"
    }
}
