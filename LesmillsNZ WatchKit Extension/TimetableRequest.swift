//
//  LmLib.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 16/02/21.
//

import Foundation

func getDate(dateStr: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale.current
    let formatTypes = ["yyyy-MM-dd'T'HH:mm:ssZ",
                       "yyyy-MM-dd HH:mm:ss Z"]
    for fmt in formatTypes {
        dateFormatter.dateFormat = fmt
        let date = dateFormatter.date(from: dateStr)
        if date != nil {
            return date
        }
    }
    return Date()
}

func createTimetableRequest(clubID:String, completionBlock: @escaping ([String: [FitnessClass]]) -> Void) {
    let exclColors = ["#000", "#000000", "black"]
    var fitnessClasses = [String: [FitnessClass]]()

    let bodyData = try? JSONSerialization.data(withJSONObject: ["club": clubID])
    let url = URL(string: "https://www.lesmills.co.nz/api/timetable/get-timetable-epi")!
    var request = URLRequest(url: url)
    request.setValue("application/json; charset=UTF-8",
                     forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = bodyData
    
    // Create the HTTP request
    URLSession.shared.dataTask(with: request) {
        data, response, error in

        // Handle the request.
        guard let data = data else {
            print("No data in response:\(error?.localizedDescription ?? "Unknown Error").")
            return
        }
        
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        // sort the data.
        if let responseJSON = responseJSON as? [String: Any] {
            if let clsData = responseJSON["Classes"] as? [Dictionary<String, Any>] {
                for cls in clsData {
                    let name: String = cls["ClassName"] as? String ?? ""
                    let duration: Int = cls["Duration"] as? Int ?? 0
                    var color: String = cls["Colour"] as? String ?? "#848484"
                    if exclColors.contains(color) {
                        color = "#848484"
                    }
                    var instructor1:String = ""
                    if let instr1 = cls["MainInstructor"] as? [String: Any] {
                        instructor1 = instr1["Name"] as? String ?? ""
                    }
                    var instructor2:String = ""
                    if let instr2 = cls["SecondaryInstructor"] as? [String: Any] {
                        instructor2 = instr2["Name"] as? String ?? ""
                    }
                        var siteName:String = ""
                    if let site = cls["Site"] as? [String: Any] {
                        siteName = site["SiteName"] as? String ?? ""
                    }
                    let dateStr: String = cls["StartDateTime"] as? String ?? ""
                    let date = getDate(dateStr:dateStr)!

                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyMMdd"
                    let clsKey = dateFormatter.string(from: date)
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd-HH:mm"
                    let timeStamp = dateFormatter.string(from: date)
                    
                    let fitnessCls = FitnessClass(
                        name: name,
                        color: color,
                        instructor1: instructor1,
                        instructor2: instructor2,
                        duration: duration,
                        location: siteName,
                        timeStamp: timeStamp)

                    fitnessClasses[clsKey, default: []].append(fitnessCls)
                }
            }
        }
        // sort fitness classes by time stamp.
        for key in Array(fitnessClasses.keys) {
            fitnessClasses[key] = fitnessClasses[key]!.sorted(
                by: {$0.timeStamp < $1.timeStamp})
        }
        completionBlock(fitnessClasses)
    }.resume()
}
