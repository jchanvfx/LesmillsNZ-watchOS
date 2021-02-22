//
//  WorkoutModel.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 15/02/21.
//

import Foundation

class FitnessClasses: ObservableObject {
    @Published var allWorkouts: [String: [FitnessClass]]

    init() {
        self.allWorkouts = [:]
    }

    func getDayText(id:String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyMMdd"
        let date = formatter.date(from: id)
        formatter.dateFormat = "E dd MMM"
        return "\(formatter.string(from: date!))"
        
    }
    
    func getDayTitle(id:String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyMMdd"
        let date = formatter.date(from: id)
        formatter.dateFormat = "E dd/MM"
        return "\(formatter.string(from: date!))"
        
    }
}
