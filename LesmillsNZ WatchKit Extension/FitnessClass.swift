//
//  FitnessClass.swift
//  LesmillsNZ
//
//  Created by Johnny Chan on 17/02/21.
//

import Foundation

func formatDate(timeStamp:String, dateFormat:String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd-HH:mm"
    let date = formatter.date(from: timeStamp)!
    formatter.dateFormat = dateFormat
    return "\(formatter.string(from: date))"
}

struct FitnessClass: Hashable {
    let name: String
    let color: String
    let instructor1: String
    let instructor2: String
    let duration: Int
    let location: String
    let timeStamp: String
    var day: String {
        return formatDate(timeStamp: timeStamp, dateFormat: "E")
    }
    var date: String {
        return formatDate(timeStamp: timeStamp, dateFormat: "dd")
    }
    var month: String {
        return formatDate(timeStamp: timeStamp, dateFormat: "MMM")
    }
    var time: String {
        return formatDate(timeStamp: timeStamp, dateFormat: "h:mm a")
    }
    var instructors: String {
        if instructor2 != "" {
            return "\(instructor1) & \(instructor2)"
        }
        return instructor1
    }
    var isFinished: Bool {
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
