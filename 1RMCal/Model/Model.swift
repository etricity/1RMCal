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
    // Performences of Exercise
    var instances : [ExerciseInstance] = []
    // current 1RM
    var bestSet : SetStat?
    
    // Constructor
    init(name : String, current1RM : Double?) {
        self.name = name
    }
    
    func addInstance(newInstance : ExerciseInstance) {
        self.instances.insert(newInstance, at: 0)
        
        //update 1RM
        updateBestSet(instance: newInstance)
    }
    
    func updateBestSet(instance : ExerciseInstance) -> Bool {
        var updated : Bool = false
        
        for set in instance.sets {
            let val = set.oneRM
            if val >= bestSet?.oneRM ?? 0 {
                bestSet = set
                updated = true
            }
        }
        return updated
    }
}

// Represents a single performence/instance of a exercise
class ExerciseInstance {
    // time exercise was performed
    var date : Date
    // Sets performed
    var sets : [SetStat]
    
    // Best Set
    var bestSet : SetStat?
    
    // Summary syntax: best set info + date performed
    var bestSetSummary : String {
        var summary : String = ""
        if let bestSet = self.bestSet {
            summary = "\(bestSet.summary)"
        }
        return summary
    }

    
    init() {
        self.sets = []
        self.date = Date()
    }
    
    // add new set
    func addSet(newSet : SetStat) {
        self.sets.append(newSet)
        
        self.bestSet = sets.max(by: { (a,b) in a.oneRM < b.oneRM })
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
    
    var summary : String {
        return "\(self.oneRM) \(self.units) (\(self.weight) \(self.units) x \(self.repCount))"
    }
    
    init(weight : Double, repCount : Int, units : Weight) {
        self.repCount = repCount
        self.weight = weight
        self.units = units
    }
}

