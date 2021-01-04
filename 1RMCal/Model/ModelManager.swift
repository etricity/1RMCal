//
//  ModelManager.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 4/1/21.
//  Copyright © 2021 Isaiah Cuzzupe. All rights reserved.
//

import Foundation

class ModelManager {
    let cd = CoreDataManager.shared
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
        cd.saveData()
        return exerciseInstance
    }
    
    func removeInstance(index : Int) -> Bool {
        var instanceRemoved : Bool = false
        
        if let _ : ExerciseInstance = exercise.getInstance(index: index) {
            exercise.removeInstance(index: index)
            instanceRemoved = true
        }
        return instanceRemoved
    }
}
