//
//  ViewModel.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 18/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import Foundation


// Eventually connection to core data


class ExerciseViewModel {
    
    // Connection to Model
    private (set) var model : ExerciseManager = ExerciseManager(test: true)
    
    func getExercises() -> [Exercise] {
        return model.exercises
    }
    
    func addExercise(name : String) -> Bool {
        return model.addExercise(name: name)
    }
    
    func removeExercise(index : Int) {
        model.removeExercise(index: index)
    }
    
    func getExercise(index : Int) -> Exercise? {
        let exercise = model.getExercise(index: index)
        return exercise
    }
        
}
