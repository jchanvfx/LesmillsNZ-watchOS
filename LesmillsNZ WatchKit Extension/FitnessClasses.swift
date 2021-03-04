//
//  WorkoutModel.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 15/02/21.
//

import Foundation

class FitnessClasses: ObservableObject {
    @Published var clubId: String = ""
    @Published var allClasses: [String: [FitnessClass]] = [:]
    @Published var isLoading: Bool = false
    @Published var requestError: String? = nil
    @Published var lastSynced: String? = nil
    
    // date ids in sorted order.
    var dateIds: [String] {
        let currentId = getCurrentDateId()
        var ids = [String]()
        for id in Array(self.allClasses.keys).sorted(by: {$0 < $1}) {
            if currentId <= id {
                ids.append(id)
            }
        }
        return ids
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
    private func onRequestRecieved(_ data: [String: [FitnessClass]], error: String?) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.requestError = error

            self.allClasses = data

            let formatter = DateFormatter()
            formatter.dateFormat = "E dd/MM - h:mm a"
            self.lastSynced = formatter.string(from: Date())
        }
    }
}
