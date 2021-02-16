//
//  ClubLocations.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 16/02/21.
//

import Foundation

struct ClubLocation: Decodable {
    let id: String
    let name: String
    let address: String
}

class ClubLocations: ObservableObject {
    let locations: [ClubLocation]
    
    var selected: ClubLocation {
        locations[0]
    }

    init() {
        let url = Bundle.main.url(
            forResource: "locations", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        locations = try! JSONDecoder().decode(
            [ClubLocation].self, from: data)
    }
}
