//
//  UrlRequest.swift
//  LesmillsNZ
//
//  Created by Johnny Chan on 30/04/21.
//

import Foundation

func createTimetableRequest(
    clubID:String, callbackFunc: @escaping ([String: [FitnessClass]], String?) -> Void) {

    var timetableData = [String:[FitnessClass]]()
    
    // url validation
    let urlStr = "https://www.lesmills.co.nz"
        + "/API/TimetablePage/GetTimetableCards?searchClubCodes="
        + "\(clubID)&searchClassCodes=&searchTrainerNames="

    guard let url = URL(string: urlStr) else {
        print("Invalid URL:\n\(urlStr)")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let config = URLSessionConfiguration.default
    config.waitsForConnectivity = true
    config.timeoutIntervalForResource = 30
    
    // Create the HTTP request
    URLSession(configuration: config).dataTask(with: request) {
        data, response, error in

        // Handle the request.
        guard let data = data else {
            let err = "\u{2297} \(error?.localizedDescription ?? "Unknown Error")"
            // error: run callback func.
            print(err)
            callbackFunc([:], err)
            return
        }
        
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
            guard let responseData = responseJSON["responseData"] as? [String:Any] else {
                let err = "Error: \"responseData\" key missing...!"
                // error: run callback func.
                print(err)
                callbackFunc([:], err)
                return
            }
            guard let cards = responseData["cards"] as? [[String:Any]] else {
                let err = "Error: \"cards\" key missing...!"
                // error: run callback func.
                print(err)
                callbackFunc([:], err)
                return
            }

            // map array to fitness classes.
            for i in cards {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: i)
                    let fitnessClass = try JSONDecoder().decode(FitnessClass.self, from: jsonData)
                    // update timetable data.
                    if (fitnessClass.dateObj != nil) {
                        timetableData[fitnessClass.dateKey!, default: []].append(fitnessClass)
                    }
                } catch {
                    print("Error: FitnessClass mapping failed")
                }
            }
        }

        // sort classes data by date object.
        for key in Array(timetableData.keys) {
            timetableData[key] = timetableData[key]!.sorted(
                by: {$0.dateObj! < $1.dateObj!})
        }

        // run callback func.
        callbackFunc(timetableData, nil)

    }.resume()
}
