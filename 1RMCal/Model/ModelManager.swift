//
//  ModelManager.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 4/1/21.
//  Copyright © 2021 Isaiah Cuzzupe. All rights reserved.
//

import Foundation

class ModelManager {
    fileprivate let cd = CoreDataManager.shared
}

class WorkoutInstanceManager : ModelManager {
    
    var exercises : [Exercise]
    var currentExercise : Exercise?
    
    init(exercises : [Exercise]) {
        self.exercises = exercises
    }
    
    func setCurrentExercise(index : Int) {
        self.currentExercise = exercises[safe : index]
    }
    
    func getExercise(index : Int) -> Exercise? {
        guard let exercise = exercises[safe: index] else {return nil}
        return exercise
    }
    
    func createInstance(name : String, sets : [SetStat]) -> ExerciseInstance {
        let exerciseInstance = cd.createExerciseInstance(name: name, sets : sets)
        
        for exercise in exercises {
            if exercise.name == name {
                exerciseInstance.exercise = exercise
                exercise.updateBestSet(instance: exerciseInstance)
            }
        }
        cd.saveData()
        return exerciseInstance
    }
}

class WorkoutsManager : ModelManager {
    
    var workouts : [Workout]? {
        return cd.getWorkouts()
    }
    
    // Get exercise by index
    func getWorkout(index : Int) -> Workout? {
        guard let workout = workouts?[safe: index] else {return nil}
        return workout
    }
    
    func workoutExists(name : String) -> Bool {
        var workoutExists : Bool = false
        if let workouts = self.workouts {
            for workout in workouts {
                if workout.name == name {
                    workoutExists = true
                }
            }
        }
        return workoutExists
    }
    
    func addWorkout(name : String, exercises : [String]) {
        cd.createWorkout(name : name, exercises : exercises)
        cd.saveData()
    }
    
    func removeWorkout(index : Int) {
        guard let workout = workouts?[safe: index] else {return}
        cd.deleteObject(object: workout)
        cd.saveData()
    }
}


class ExercisesManager : ModelManager {
        
    var exercises : [Exercise]? {
        return cd.getExercises()
    }
    
    func metaData() -> [String] {
        var metaData : [String] = []
        
        if let exercises = self.exercises {
            for exercise in exercises {
                metaData.append(exercise.name)
            }
        }
        return metaData
    }
    
    // Get exercise by index
    func getExercise(index : Int) -> Exercise? {
        guard let exercise = exercises?[safe: index] else {return nil}
        return exercise
    }
    
    func exerciseExists(name : String) -> Bool {
        var exerciseExists : Bool = false
        if let exercises = self.exercises {
            for exercise in exercises {
                if exercise.name == name {
                    exerciseExists = true
                }
            }
        }
        return exerciseExists
    }
    
    func addExercise(name : String) {
        cd.createExercise(name: name)
        cd.saveData()
    }
    
    func removeExercise(index : Int) {
        guard let exercise = exercises?[safe: index] else {return}
        cd.deleteObject(object: exercise)
        cd.saveData()
    }
}

class ExerciseManager : ModelManager {
    
    private (set) var exercise : Exercise
    var numInstances : Int {
        return exercise.instances?.count ?? 0
    }
    
    init(exercise : Exercise) {
        self.exercise = exercise
    }
    
    func createInstance(name : String, sets : [SetStat]) -> ExerciseInstance {
        let exerciseInstance = cd.createExerciseInstance(name: name, sets : sets)
        
        // relation is inversed & data saved
        exerciseInstance.exercise = self.exercise
        exercise.updateBestSet(instance: exerciseInstance)
        cd.saveData()
        return exerciseInstance
    }
    
    func getInstance(index : Int) -> ExerciseInstance? {
        return exercise.getInstance(index: index)
    }
    
    func removeInstance(index : Int) -> Bool {
        var instanceRemoved : Bool = false
        
        if let instance : ExerciseInstance = exercise.getInstance(index: index) {
            exercise.removeInstance(instance: instance)
            cd.deleteObject(object: instance)
            cd.saveData()
            instanceRemoved = true
        }
        return instanceRemoved
    }
}

class SetStatManager : ModelManager {
    
    private (set) var sets : [SetStat]
    
    init(sets : [SetStat] = []) {
        self.sets = sets
    }
    
    func addSet(set : SetStat) {
        sets.append(set)
    }
    
    func createSetStat(weight: Double, repCount: Double, unitString: String) -> SetStat {
        let set = cd.createSetStat(weight: weight, repCount: repCount, unitString: unitString)
        cd.saveData()
        return set
    }
    
    func getSet(index : Int) -> SetStat? {
        return sets[safe: index]
    }
}
