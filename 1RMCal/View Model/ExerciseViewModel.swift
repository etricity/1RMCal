//
//  ViewModel.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 18/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import Foundation

class ExerciseViewModel {
    
    // Connection to Model
    var model : ExerciseManager = ExerciseManager()
    
    func getExercises() -> [Exercise] {
        return model.exercises
    }
    
    func addExercise(name : String) -> Bool {
        return model.addExercise(name: name)
    }
    
    func removeExercise(index : Int) {
        model.removeExercise(index: index)
    }
        
}
