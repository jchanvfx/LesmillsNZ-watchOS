//
//  FitnessClass.swift
//  LesmillsNZ
//
//  Created by Johnny Chan on 17/02/21.
//

import Foundation

struct FitnessClass: Codable {
    let name: String
    let color: String
    let instructor1: String
    let instructor2: String
    let duration: Int
    let location: String
    let timeStamp: String
    var day: String {
        return formatTimeStamp(timeStamp: timeStamp,
                               formatStr: "E")
    }
    var date: String {
        return formatTimeStamp(timeStamp: timeStamp,
                               formatStr: "dd")
    }
    var month: String {
        return formatTimeStamp(timeStamp: timeStamp,
                               formatStr: "MMM")
    }
    var time: String {
        return formatTimeStamp(timeStamp: timeStamp,
                               formatStr: "h:mm a")
    }
    var instructors: String {
        if instructor2 != "" {
            return "\(instructor1) & \(instructor2)"
        }
        return instructor1
    }
    var isStarted: Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH:mm"
        var date = formatter.date(from: timeStamp)!
        // 5 mins offset.
        date.addTimeInterval(300)
        return date < Date()
    }
    
    static let example = FitnessClass(
        name: "TEST CLASS",
        color: "#FFB81C",
        instructor1: "Username 1",
        instructor2: "Username 2",
        duration: 45,
        location: "Studio 1",
        timeStamp: "2021-02-17-04:27"
    )
}
