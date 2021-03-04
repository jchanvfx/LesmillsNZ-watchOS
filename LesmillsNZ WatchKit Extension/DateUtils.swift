//
//  utils.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 22/02/21.
//

import Foundation

func getCurrentDateId() -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.locale = Locale.current
    formatter.dateFormat = "yyMMdd"
    return "\(formatter.string(from: Date()))"
}

func getDateFromString(_ dateStr: String) -> Date? {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.locale = Locale.current
    let formatTypes = [
        "yyyy-MM-dd'T'HH:mm:ssZ",
        "yyyy-MM-dd HH:mm:ss Z"
    ]
    for fmt in formatTypes {
        formatter.dateFormat = fmt
        let date = formatter.date(from: dateStr)
        if date != nil {
            return date
        }
    }
    return Date()
}

func formatTimeStamp(_ timeStamp:String, _ formatStr:String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd-HH:mm"
    let date = formatter.date(from: timeStamp)!
    formatter.dateFormat = formatStr
    return "\(formatter.string(from: date))"
}

func formatDateId(_ id:String, _ dateFormat:String) -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.locale = Locale.current
    formatter.dateFormat = "yyMMdd"
    let date = formatter.date(from: id)
    formatter.dateFormat = dateFormat
    return "\(formatter.string(from: date!))"
}
