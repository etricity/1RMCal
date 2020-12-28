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
    
    private (set) var name : String
    private (set) var exercises : [Exercise] = []
    
    // test purposes only
    init(name : String = "", test : Bool = false){
        self.name = name
        
        if test {
            testData()
        }
        
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
    
    // swap exercises
    func swapExercises(x : Int, y : Int) {
        let validIndices = exercises.indices
        if validIndices.contains(x) && validIndices.contains(y) {
            self.exercises.swapAt(x, y)
        }
    }
    
    func getExercise(index : Int) -> Exercise? {
        if exercises.indices.contains(index) {
            return exercises[index]
        } else {
            return nil
        }
    }
    
    
    // Only used when used as a Workout
    private (set) var instances : [WorkoutInstance] = []
    
    func addWorkoutInstance(newWorkout : WorkoutInstance) {
        instances.insert(newWorkout, at: 0)
    }
    func removeInstance(index : Int) {
        if self.instances.indices.contains(index) {
            self.instances.remove(at: index)
        }
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
        
        let exercises = ExerciseManager(name: "Compound Movements")
        
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
        exercises.addExercise(exercise: benchPress)
        exercises.addExercise(exercise: squat)
        exercises.addExercise(exercise: deadlift)
        
        self.addWorkout(newWorkout: exercises)
    }

    
}
