//
//  ModelManagerCD.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 2/1/21.
//  Copyright © 2021 Isaiah Cuzzupe. All rights reserved.
//

import Foundation

// All interactions with model happens with this class

class ModelManager {
    
    let model = CoreDataManager.shared
    private (set) var workouts : [WorkoutCD]?
    private (set) var exercises : [ExerciseCD]?
    
    init() {
        workouts = model.getWorkouts()
        exercises = model.getExercises()
    }
    
    // Exercise Management Functions
    
    // add new exercise by name
    func addExercise(name : String) {
        
        if let exercises = self.exercises {
            let exerciseExists = exercises.contains { exercise in
                return exercise.name.lowercased() == name.lowercased()
            }
            
            if !exerciseExists {
                let newExercise = model.createExercise(name: name)
                self.exercises!.append(newExercise)
            }
        }
    }
    
    // add existing exercise
    func addExercise(exercise : ExerciseCD) {
        self.exercises?.append(exercise)
    }
    
    // Remove exercise
    func removeExercise(index : Int) {
        if let exercises = self.exercises {
            if exercises.indices.contains(index) {
                self.exercises!.remove(at: index)
            }
        }
    }
    
    // swap exercises
    func swapExercises(x : Int, y : Int) {
        
        if let exercises = self.exercises {
            let validIndices = 0...exercises.count - 1
            if validIndices.contains(x) && validIndices.contains(y) {
                self.exercises!.swapAt(x, y)
            }
        }
    }
    
    // get exercise by index
    func getExercise(index : Int) -> ExerciseCD? {
        
        var exercise : ExerciseCD? = nil
        
        if let exercises = self.exercises {
            let lowerBound = 0
            let upperBound = exercises.count - 1
            
            if (lowerBound...upperBound).contains(index) {
                exercise =  exercises[index]
            }
        }
        return exercise
    }
    
    
    
    // Workout Management Functions
    
    // add new workout
    func addWorkout(name : String) {
        if let workouts = self.workouts {
            
            let workoutExists = workouts.contains { workout in
                return workout.name.lowercased() == name.lowercased()
            }
            
            if !workoutExists {
                let newWorkout = model.createWorkout(name: name)
                self.workouts!.append(newWorkout)
            }
        }
    }
    
    // Remove workout
    func removeWorkout(index : Int) {
        if let workouts = self.workouts {
            if workouts.indices.contains(index) {
                self.workouts!.remove(at: index)
            }
        }
    }
    
    // Get Workout
    func getWorkout(index : Int) -> WorkoutCD? {
        var workout : WorkoutCD? = nil
        if let workouts = self.workouts {
            let lowerBound = 0
            let upperBound = workouts.count - 1
            
            if (lowerBound...upperBound).contains(index) {
                workout =  workouts[index]
            }
        }
        return workout
    }
}
