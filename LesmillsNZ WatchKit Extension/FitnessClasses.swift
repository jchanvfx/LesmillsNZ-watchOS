//
//  WorkoutModel.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 15/02/21.
//

import Foundation

class FitnessClasses: ObservableObject {
    let workoutsClasses: [FitnessClass]
    var today: FitnessClass {
        workoutsClasses[0]
    }
    
    init() {
        workoutsClasses = [FitnessClass.example]
    }
}
