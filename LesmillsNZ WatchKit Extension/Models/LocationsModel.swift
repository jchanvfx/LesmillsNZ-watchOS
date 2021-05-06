//
//  Locations.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 28/04/21.
//

import Foundation

struct ClubLocationModel: Decodable {
    let id: String
    let name: String
    let address: String

    static var example = ClubLocationModel(
        id: "04",
        name: "TARANAKI STREET",
        address: "52-70 Taranaki St, Wellington"
    )

}

class ClubLocationsModel: ObservableObject {
    var locations: [ClubLocationModel]
    var count: Int

    init(preview:Bool=false) {
        if preview {
            self.locations = [ClubLocationModel.example]
            self.count = 1
            return
        }
        let url = Bundle.main.url(forResource: "locations", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        self.locations = try! JSONDecoder().decode([ClubLocationModel].self, from: data)
        self.count = self.locations.count
    }

    func getClubById(id:String) -> ClubLocationModel? {
        for club in self.locations {
            if club.id == id {
                return club
            }
        }
        return nil
    }

}
