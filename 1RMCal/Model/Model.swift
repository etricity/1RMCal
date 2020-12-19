//
//  Exercise.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 18/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import Foundation

// Model Management


// Represents a Exercise (holds info for the exxercises name & all performences of the exxcercise)
class Exercise {
        
    // Name of exercise
    var name : String
    //Performences of Exercise
    var instances : [ExerciseInstance] = []
    
    // Constructor
    init(name : String) {
        self.name = name
    }
}

// Represents a single performence/instance of a exercise
class ExerciseInstance {
    // time exercise was performed
    var date : Date
    // Sets performed
    var sets : [SetStat]
    
    init() {
        self.sets = []
        self.date = Date()
    }
    
    // add new set
    func performSet(weight : Double, repCount : Int, units : Weight) {
        let newSet = SetStat(weight: weight, repCount: repCount, units: units)
        self.sets.append(newSet)
    }
    
}



// Represents a single set in a exercise instance
class SetStat {
    
    var repCount : Int
    var weight : Double
    var units : Weight
    
    var oneRM : Double {
        var val = self.weight * (1 + (Double(self.repCount)/30))
        val = val.rounded()
        return val
    }
    
    init(weight : Double, repCount : Int, units : Weight) {
        self.repCount = repCount
        self.weight = weight
        self.units = units
    }
}

