//
//  utils.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 22/02/21.
//

import SwiftUI

// extend Color object to support hex string.
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// date utils
func getDateFromString(dateStr: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale.current
    let formatTypes = [
        "yyyy-MM-dd'T'HH:mm:ssZ",
        "yyyy-MM-dd HH:mm:ss Z"
    ]
    for fmt in formatTypes {
        dateFormatter.dateFormat = fmt
        let date = dateFormatter.date(from: dateStr)
        if date != nil {
            return date
        }
    }
    return Date()
}

func formatDayTextFromId(id:String) -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.locale = Locale.current
    formatter.dateFormat = "yyMMdd"
    let date = formatter.date(from: id)
    formatter.dateFormat = "E dd MMM"
    return "\(formatter.string(from: date!))"
}

func formatDateTitleFromId(id:String) -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.locale = Locale.current
    formatter.dateFormat = "yyMMdd"
    let date = formatter.date(from: id)
    formatter.dateFormat = "E dd/MM"
    return "\(formatter.string(from: date!))"
}
