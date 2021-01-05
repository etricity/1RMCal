//
//  ModelManager.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 18/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import Foundation

//class Workout : ExerciseManagerOLD {
//    private (set) var name : String
//    
//    init(name : String,test : Bool = false){
//        self.name = name
//        super.init()
//        
//        if test {
//            testData()
//        }
//        
//    }
//    
//    // Only used when used as a Workout
//    private (set) var instances : [WorkoutInstance] = []
//    
//    func addWorkoutInstance(newWorkout : WorkoutInstance) {
//        instances.insert(newWorkout, at: 0)
//    }
//    func removeInstance(index : Int) {
//        if self.instances.indices.contains(index) {
//            self.instances.remove(at: index)
//        }
//    }
//
//}

// Managers all exercises
class ExerciseManagerOLD {
    private (set) var exercises : [Exercise] = []
    
    // test purposes only
    init(test : Bool = false){
        
        if test {
            testData()
        }
    }
    
    // swap exercises
    func swapExercises(x : Int, y : Int) {
        let validIndices = exercises.indices
        if validIndices.contains(x) && validIndices.contains(y) {
            self.exercises.swapAt(x, y)
        }
    }
    
    // Add new exercise
    func addExercise(name : String) -> Bool {
        
        let exerciseExists = exercises.contains { exercise in
            return exercise.name.lowercased() == name.lowercased()
        }
        
        if !exerciseExists {
//            self.exercises.append(Exercise(name: name, current1RM: 0))
            return true
        } else {
            return false
        }
    }
    //test purposes only
    func addExercise(exercise : Exercise) {
        self.exercises.append(exercise)
    }
    
    // Remove exercise
    func removeExercise(index : Int) {
        
        if self.exercises.indices.contains(index) {
            self.exercises.remove(at: index)
        }
    }
        
    func getExercise(index : Int) -> Exercise? {
        if exercises.indices.contains(index) {
            return exercises[index]
        } else {
            return nil
        }
    }
    
    
    
    func testData() {
    }
    
}

// Managers all workouts
class WorkoutManager {
    
    private (set) var workouts : [Workout] = []
    
    init() {
        testData()
    }
    
    func addWorkout(newWorkout : Workout) -> Bool {
        let workoutExists = workouts.contains { workout in
            return workout.name.lowercased() == newWorkout.name.lowercased()
        }
        
        if !workoutExists {
            self.workouts.append(newWorkout)
            return true
        } else {
            return false
        }
    }
    
    func removeWorkout(index : Int) {
        self.workouts.remove(at: index)
    }
    
    func getWorkout(index : Int) -> Workout? {
        if workouts.indices.contains(index) {
            return workouts[index]
        } else {
            return nil
        }
    }
    
    
    func testData() {

    }

    
}
