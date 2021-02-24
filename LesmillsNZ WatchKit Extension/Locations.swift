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
    var count: Int {
        self.locations.count
    }

    init() {
        let url = Bundle.main.url(
            forResource: "locations", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        self.locations = try! JSONDecoder().decode(
            [ClubLocation].self, from: data)
    }
    
    func getClubById(id:String) -> ClubLocation? {
        for club in self.locations {
            if club.id == id {
                return club
            }
        }
        return nil
    }
}
