//
//  WorkoutModel.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 15/02/21.
//

import Foundation

class FitnessClasses: ObservableObject {
    @Published var allClasses: [String: [FitnessClass]]

    init() {
        self.allClasses = [:]
    }

    func formatDayText(id:String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyMMdd"
        let date = formatter.date(from: id)
        formatter.dateFormat = "E dd MMM"
        return "\(formatter.string(from: date!))"
        
    }
    
    func formatDateTitle(id:String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyMMdd"
        let date = formatter.date(from: id)
        formatter.dateFormat = "E dd/MM"
        return "\(formatter.string(from: date!))"
        
    }
}
