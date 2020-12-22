//
//  ModelManager.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 18/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import Foundation

// Managers all exercises
class ExerciseManager {
    
    var exercises : [Exercise] = []
    
    // test purposes only
    init() {
        testData()
    }
    
    // Add new exercise
    func addExercise(name : String) -> Bool {
        
        let exerciseExists = exercises.contains { exercise in
            return exercise.name.lowercased() == name.lowercased()
        }
        
        if !exerciseExists {
            self.exercises.append(Exercise(name: name, current1RM: 0))
            return true
        } else {
            return false
        }
    }
    
    // Remove exercise
    func removeExercise(index : Int) {
        exercises.remove(at: index)
    }
    
    // Get a single exercise by name
    func getExercise(name : String) -> Exercise? {
        
        guard let exercise = exercises.filter({ $0.name.lowercased() == name.lowercased() }).first else {return nil}
        return exercise
    }
    
    
    
    
    func testData() {
        let benchPress = Exercise(name: "Bench Press", current1RM: 0)
        let squat = Exercise(name: "Squat", current1RM: 0)
        let deadlift = Exercise(name: "Deadlift", current1RM: 0)
        
        let newInstance = ExerciseInstance()
        let set1 = SetStat(weight: 100, repCount: 10, units: .kg)
        let set2 = SetStat(weight: 120, repCount: 8, units: .kg)
        let set3 = SetStat(weight: 135, repCount: 7, units: .kg)
        newInstance.addSet(newSet: set1)
        newInstance.addSet(newSet: set2)
        newInstance.addSet(newSet: set3)
        
        benchPress.addInstance(newInstance: newInstance)
        
        // Test Data for pre-core data development
        self.exercises.append(benchPress)
        self.exercises.append(squat)
        self.exercises.append(deadlift)
    }
    
}

// A workout is a exercise manager with a set of exercises
typealias Workout = ExerciseManager

// Managers all workouts
class WorkoutManager {
    var workouts : [Workout] = []
}
