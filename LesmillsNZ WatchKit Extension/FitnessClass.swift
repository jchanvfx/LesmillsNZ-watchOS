//
//  FitnessClass.swift
//  LesmillsNZ
//
//  Created by Johnny Chan on 17/02/21.
//

import Foundation

struct FitnessClass {
    let name: String
    let color: String
    let instructor1: String
    let instructor2: String
    let duration: Int
    let location: String
    let dateObject: Date
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return "\(formatter.string(from: dateObject))"
    }
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return "\(formatter.string(from: dateObject))"
    }
    var month: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return "\(formatter.string(from: dateObject))"
    }
    var time: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return "\(formatter.string(from: dateObject))"
    }
    var instructors: String {
        if instructor2 != "" {
            return "\(instructor1) & \(instructor2)"
        }
        return instructor1
    }
    
    static let example = FitnessClass(
        name: "BodyAttack",
        color: "#FFB81C",
        instructor1: "Zak Feng",
        instructor2: "Mana Williams",
        duration: 45,
        location: "Studio 1",
        dateObject: Date()
    )
}
