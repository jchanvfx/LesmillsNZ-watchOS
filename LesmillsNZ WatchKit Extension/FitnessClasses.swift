//
//  WorkoutModel.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 15/02/21.
//

import Foundation

class FitnessClasses: ObservableObject {
    @Published var clubId: String
    @Published var allClasses: [String: [FitnessClass]]
    @Published var isLoading: Bool
    @Published var lastSynced: String? = nil

    init() {
        self.clubId = ""
        self.allClasses = [:]
        self.isLoading = false
    }

    // creates the time table request when the current club id.
    func createRequest() {
        if self.clubId == "" {
            self.isLoading = false
            return
        }
        self.isLoading = true
        createTimetableRequest(
            clubID: clubId,
            completionBlock: self.onRequestRecieved)
    }
    
    // callback method when the request data has been recieved.
    func onRequestRecieved(requestData: [String: [FitnessClass]]) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.allClasses = requestData

            let formatter = DateFormatter()
            formatter.dateFormat = "E dd/MM - h:mm a"
            self.lastSynced = formatter.string(from: Date())
        }
    }

}
