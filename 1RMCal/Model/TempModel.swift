//
//  TempModel.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 3/1/21.
//  Copyright © 2021 Isaiah Cuzzupe. All rights reserved.
//

import Foundation

// Managers all exercises
class WorkoutTemp {
    private (set) var name : String
    private (set) var exercises : [ExerciseCD]
    
    // test purposes only
    init(name : String) {
        self.name = name
        self.exercises = []
    }
    
    // swap exercises
    func swapExercises(x : Int, y : Int) {
        let validIndices = exercises.indices
        if validIndices.contains(x) && validIndices.contains(y) {
            self.exercises.swapAt(x, y)
        }
    }

    //test purposes only
    func addExercise(exercise : ExerciseCD) {
        self.exercises.append(exercise)
    }
    
    
    // Remove exercise
    func removeExercise(index : Int) {
        
        if self.exercises.indices.contains(index) {
            self.exercises.remove(at: index)
        }
    }

        
    func getExercise(index : Int) -> ExerciseCD? {
        if exercises.indices.contains(index) {
            return exercises[index]
        } else {
            return nil
        }
    }
}
