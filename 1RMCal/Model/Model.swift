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
    private (set) var name : String
    // Performences of Exercise
    private (set) var instances : [ExerciseInstance] = []
    // current 1RM
    var bestSet : SetStat?
    
    // Constructor
    init(name : String, current1RM : Double?) {
        self.name = name
    }
    
    // Add new instance
    func addInstance(newInstance : ExerciseInstance) {
        self.instances.insert(newInstance, at: 0)
        //update 1RM
        updateBestSet(instance: newInstance)
    }
    
    // Remove instance
    func removeInstance(index : Int) {
        if instances.indices.contains(index) {
            self.instances.remove(at: index)
        }
    }
    
    // Update best set
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
    private (set) var date : Date
    // Sets performed
    private (set) var sets : [SetStat]
    
    // Best Set
    private (set) var bestSet : SetStat?
    
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
    
    private (set) var repCount : Int
    private (set) var weight : Double
    private (set) var units : Weight
    
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

