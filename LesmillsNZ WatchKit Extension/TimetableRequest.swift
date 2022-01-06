//
//  UrlRequest.swift
//  LesmillsNZ
//
//  Created by Johnny Chan on 30/04/21.
//

import Foundation

struct NetworkManager {
    
    enum NetworkError: LocalizedError {
        case invalidURL(string: String)
        case badResponse(string: String)
        case decodingError(string: String)
        
        var errorDescription: String? {
            switch self {
            case .invalidURL(let url):
                return "Unable to create url from \(url)"
            case .badResponse(let description):
                return description
            case .decodingError(let description):
                return description
            }
        }
    }
    
    static let shared = NetworkManager()

    func timetable(for clubID: String) async throws -> [String: [FitnessClass]] {
        
        var timetableData = [String:[FitnessClass]]()
        
        // url validation
        let urlStr = "https://www.lesmills.co.nz"
            + "/API/TimetablePage/GetTimetableCards?searchClubCodes="
            + "\(clubID)&searchClassCodes=&searchTrainerNames="

        guard let url = URL(string: urlStr) else {
            throw NetworkError.invalidURL(string: urlStr)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badResponse(string: "Bad Request")
        }
        
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
            guard let responseData = responseJSON["responseData"] as? [String:Any] else {
                let err = "Error: \"responseData\" key missing...!"
                // error: run callback func.
                throw NetworkError.decodingError(string: err)
            }
            guard let cards = responseData["cards"] as? [[String:Any]] else {
                let err = "Error: \"cards\" key missing...!"
                // error: run callback func.
                throw NetworkError.decodingError(string: err)
            }
            
            // map array to fitness classes.
            for i in cards {
                let jsonData = try JSONSerialization.data(withJSONObject: i)
                let fitnessClass = try JSONDecoder().decode(FitnessClass.self, from: jsonData)
                // update timetable data.
                if (fitnessClass.dateObj != nil) {
                    timetableData[fitnessClass.dateKey!, default: []].append(fitnessClass)
                }
                
            }
        }

        // sort classes data by date object.
        for key in Array(timetableData.keys) {
            timetableData[key] = timetableData[key]!.sorted(
                by: {$0.dateObj! < $1.dateObj!})
        }

        // run callback func.
        return timetableData
        
    }
        
}

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

    
    // Create the HTTP request
    URLSession.shared.dataTask(with: request) {
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
