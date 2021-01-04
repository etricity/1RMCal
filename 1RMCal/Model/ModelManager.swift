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

class ExerciseManager : ModelManager {
        
    var exercises : [Exercise]? {
        return cd.getExercises()
    }
    
    // Get exercise by index
    func getExercise(index : Int) -> Exercise? {
        guard let exercise = exercises?[safe: index] else {return nil}
        return exercise
    }
    
    func exerciseExists(name : String) -> Bool {
        let exerciseExists : Bool = false
        if let exercises = self.exercises {
            for exercise in exercises {
                if exercise.name == name {
                    exerciseExists
                }
            }
        }
        return exerciseExists
    }
    
    func addExercise(name : String) {
        cd.createExercise(name: name)
    }
    
    func removeExercise(index : Int) {
        guard let exercise = exercises?[safe: index] else {return}
        cd.deleteObject(object: exercise)
    }
}

class ExerciseInstanceManager : ModelManager {
    
    var exercise : Exercise
    
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
    
    func removeInstance(index : Int) -> Bool {
        var instanceRemoved : Bool = false
        
        if let _ : ExerciseInstance = exercise.getInstance(index: index) {
            exercise.removeInstance(index: index)
            exercise.updateBestSet()
            instanceRemoved = true
        }
        return instanceRemoved
    }
}

class SetStatManager : ModelManager {
    
    func createSetStat(weight: Double, repCount: Double, unitString: String) -> SetStat {
        let set = cd.createSetStat(weight: weight, repCount: repCount, unitString: unitString)
        cd.saveData()
        return set
    }
}
