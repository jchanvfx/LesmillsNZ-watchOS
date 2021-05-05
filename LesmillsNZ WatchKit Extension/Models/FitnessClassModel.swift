//
//  FitnessClassModel.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 2/05/21.
//

import Foundation

// fitness class color overrides.
let defaultColors = [
    "BODYATTACK"     : "#FFB81C",
    "BODYBALANCE"    : "#C5E86C",
    "BODYCOMBAT"     : "#787121",
    "BODYJAM"        : "#FEDD00",
    "BODYPUMP"       : "#E4002B",
    "BODYSTEP"       : "#008C95",
    "LES MILLS CORE" : "#E35205",
    "RPM"            : "#00A9E0",
    "SH'BAM"         : "#D0006F",
    "SPRINT"         : "#FEDD00",
    "TONE"           : "#8246AF"
]
// exculde black color for since background is black.
let excludeColors = ["#", "#000", "#000000", "black"]

struct FitnessClass: Codable {
    
    // mapping values from lesmills.co.nz GET request.
    let className: String?
    let colorHexCode: String?
    let mainInstructorName: String?
    let secondaryInstructorName: String?
    let durationMins: Int?
    let siteName: String?
    let startDate: String?
    let startTime: String?
    
    // methods.
    func getFormattedDate(dateFormat:String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = dateFormat
        return formatter.string(from: dateObj!)
    }

    // attributes used by the views.
    var dateObj: Date? {
        guard startDate != nil else {
            print("startDate data missing!")
            return nil
        }
        guard startTime != nil else {
            print("startTime data missing!")
            return nil
        }
        let dateStr = "\(startDate!) \(startTime!)"
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "dd MMM yyyy HH:mm"
        let date = formatter.date(from: dateStr)
        return date
    }
    var dateKey: String? {
        guard dateObj != nil else {
            print("no data from dateObject")
            return nil
        }
        return getFormattedDate(dateFormat: "yyMMdd")
    }

    var nameText: String {
        guard className != nil else {return "NO DATA"}
        return className!.uppercased()
    }
    var colorText: String {
        guard colorHexCode != nil else {return "#848484"}
        // override default color by the class name.
        let name = nameText
        for (k, v) in defaultColors {
            if name.contains(k) {return v}
        }
        // override default color by the class name.
        let color = "#\(colorHexCode!)"
        if excludeColors.contains(color) {
           return "#848484"
        }
        return color
    }
    var instructor1Text: String {
        guard mainInstructorName != nil else {return ""}
        return mainInstructorName!
    }
    var instructor2Text: String {
        guard secondaryInstructorName != nil else {return ""}
        // TEMP: work around fix we sanitize secondary instructor name
        //       because the lesmills database is returning the name
        //       with a leading "  + " prefix for some reason.
        let regex = try! NSRegularExpression(pattern: "^\\s++\\+\\s")
        let name = regex.replaceMatch(secondaryInstructorName!, "")
        return name
    }
    var instructorsText: String {
        if instructor2Text != "" {
            return "\(instructor1Text) & \(instructor2Text)"
        }
        return instructor1Text
    }
    var durationText: String {
        guard durationMins != nil else {return "0"}
        return "\(durationMins!)"
    }
    var locationText: String {
        guard siteName != nil else {return "NO DATA"}
        return "\(siteName!)"
    }
    var dayText: String {
        return getFormattedDate(dateFormat: "E")
    }
    var dateText: String {
        return getFormattedDate(dateFormat: "dd")
    }
    var monthText: String {
        return getFormattedDate(dateFormat: "MMM")
    }
    var timeText: String {
        return getFormattedDate(dateFormat: "h:mm a").lowercased()
    }
    var hasStarted: Bool {
        return dateObj! < Date()
    }
    
    // example test data for preview.
    static let example = FitnessClass(
        className: "BODYATTACK",
        colorHexCode: "#FFB81C",
        mainInstructorName: "Text 1",
        secondaryInstructorName: "Text 2",
        durationMins: 45,
        siteName: "Studio 1",
        startDate: "05 May 2021",
        startTime: "18:45"
    )
}
