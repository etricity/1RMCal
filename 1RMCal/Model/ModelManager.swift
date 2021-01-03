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
    var workouts : [WorkoutCD]? {
        return model.getWorkouts()
    }
    var exercises : [ExerciseCD]? {
        return model.getExercises()
    }
    
    // Exercise Management Functions
    
    // add new exercise by name
//    func addExercise(name : String) {
//        
//        if let exercises = self.exercises {
//            let exerciseExists = exercises.contains { exercise in
//                return exercise.name.lowercased() == name.lowercased()
//            }
//            
//            if !exerciseExists {
//                let newExercise = model.createExercise(name: name)
//                self.exercises!.append(newExercise)
//            }
//        }
//    }
    
    // add existing exercise
//    func addExercise(exercise : ExerciseCD) {
//        self.exercises?.append(exercise)
//    }
//    
//    // Remove exercise
//    func removeExercise(index : Int) {
//        if let exercises = self.exercises {
//            if exercises.indices.contains(index) {
//                self.exercises!.remove(at: index)
//            }
//        }
//    }
    
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
    func addWorkout(newWorkout : WorkoutTemp) -> Bool {
        var workoutAdded : Bool = false
        if let workouts = self.workouts {
            
            let workoutExists = workouts.contains { workout in
                return workout.name.lowercased() == newWorkout.name.lowercased()
            }
            
            if !workoutExists {
                model.createWorkout(tempWorkout : newWorkout)
            }
            workoutAdded = !workoutExists
        }
        model.saveData()
        return workoutAdded
    }
    
    // Remove workout
    func removeWorkout(workout : WorkoutCD) {
        model.managedContext.delete(workout)
        model.saveData()
    }
    
    // Get Workout by index
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
    
    // Get Workout by name
    func getWorkout(name : String) -> WorkoutCD? {
        var workoutToReturn : WorkoutCD? = nil
        if let workouts = self.workouts {
            
            for workout in workouts {
                if workout.name.lowercased() == name.lowercased() {
                    workoutToReturn = workout
                }
            }
            
        }
        return workoutToReturn
    }
    
    func workoutExists(name : String) -> Bool {
        var workoutExists : Bool = false
        if let workouts = self.workouts {
            
            for workout in workouts {
                if workout.name.lowercased() == name.lowercased() {
                    workoutExists = true
                }
            }
            
        }
        return workoutExists
    }
}
