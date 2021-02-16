//
//  WorkoutModel.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 15/02/21.
//

import Foundation

struct FitnessClass {
    let id: Int
    let name: String
    let color: String
    let instructor1: String
    let instructor2: String
    let duration: Int
    let location: String
    let day: String
    let date: String
    let month: String
    let time: String
    
    static let example = FitnessClass(
        id: 1,
        name: "BodyPump",
        color: "#FF0000",
        instructor1: "Test User 1",
        instructor2: "Test User 1",
        duration: 45,
        location: "Studio 1",
        day: "Sun",
        date: "14",
        month: "Feb",
        time: "10:00am"
    )
}


class FitnessClasses: ObservableObject {
    let workoutsClasses: [FitnessClass]
    var today: FitnessClass {
        workoutsClasses[0]
    }
    
    init() {
        workoutsClasses = [FitnessClass.example]
    }
}
