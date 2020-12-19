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
        let benchPress = Exercise(name: "Bench Press")
        let squat = Exercise(name: "Squat")
        let deadlift = Exercise(name: "Deadlift")
        
        self.exercises.append(benchPress)
        self.exercises.append(squat)
        self.exercises.append(deadlift)
    }
    
    // Add new exercise
    func addExercise(name : String) -> Bool {
        
        let exerciseExists = exercises.contains { exercise in
            return exercise.name.lowercased() == name.lowercased()
        }
        
        if !exerciseExists {
            self.exercises.append(Exercise(name: name))
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
    
}

// A workout is a exercise manager with a set of exercises
typealias Workout = ExerciseManager

// Managers all workouts
class WorkoutManager {
    var workouts : [Workout] = []
}
