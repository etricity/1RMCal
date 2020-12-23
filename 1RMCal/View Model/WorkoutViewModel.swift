//
//  WorkoutViewModel.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 23/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import Foundation

class WorkoutViewModel {
    
    // Connection to Model
    var model : WorkoutManager = WorkoutManager()
    
    func getWorkouts() -> [Workout] {
        return model.workouts
    }
    
//    func addWorkout(name : String) -> Bool {
//        return model.addWorkout(name : name)
//    }
//    
//    func removeExercise(index : Int) {
//        model.removeWorkout(index: index)
//    }
//    
//    func getWorkout(name : String) -> Workout? {
//        let workout = model.getWorkout(name: name)
//        return workout
//    }
}
