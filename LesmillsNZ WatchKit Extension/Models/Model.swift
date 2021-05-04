//
//  Model.swift
//  LesmillsNZ
//
//  Created by Johnny Chan on 29/04/21.
//

import Foundation

class Model: ObservableObject {
    @Published var previewMode: Bool
    @Published var selectedClub: String = ""
    @Published var isLoading: Bool = false
    @Published var allClasses: [String: [FitnessClass]] = [:]
    @Published var requestError: String?

    // functions

    init(preview:Bool=false) {
        self.previewMode = preview
        if preview {
            self.selectedClub = "04"
            self.allClasses = ["210505": [FitnessClass.example]]
            return
        }
        // read user app settings.
        self.selectedClub = UserDefaults.standard.string(forKey: "clubID") ?? ""
    }
    
    func setSelectedClub(clubID:String) {
        if self.previewMode {
            self.selectedClub = clubID
            return
        }
        self.selectedClub = clubID
        UserDefaults.standard.set(self.selectedClub, forKey: "clubID")
    }
    
    func makeDataRequest() {
        if self.selectedClub == "" {
            self.isLoading = false
            return
        }
        self.isLoading = true
        createTimetableRequest(
            clubID:self.selectedClub, callbackFunc:self.onDataRequestRevieved)
    }
    
    private func onDataRequestRevieved(
        _ timetableData: [String:[FitnessClass]], _ error:String?) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.requestError = error
            self.allClasses = timetableData
        }
    }
    
    func getButtonLabels() -> [(String, String)] {
        let fmtDate = DateFormatter()
        fmtDate.timeZone = TimeZone.current
        fmtDate.locale = Locale.current
        fmtDate.dateFormat = "yyMMdd"
        let fmtLabel = DateFormatter()
        fmtLabel.timeZone = TimeZone.current
        fmtLabel.locale = Locale.current
        fmtLabel.dateFormat = "E dd MMM"
        var array = [(key:String, label:String)]()
        for key in Array(self.allClasses.keys).sorted(by: {$0 < $1}) {
            let date = fmtDate.date(from: key)
            let label = fmtLabel.string(from: date!)
            array.append((key, label))
        }
        return array
    }
    
    func getClassesByDate(_ dateKey:String) -> [FitnessClass] {
        guard self.allClasses[dateKey] != nil else {return []}
        return self.allClasses[dateKey]!
    }

}
