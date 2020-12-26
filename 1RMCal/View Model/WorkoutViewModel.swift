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
    private (set) var model : WorkoutManager = WorkoutManager()
    
    func getWorkouts() -> [Workout] {
        return model.workouts
    }
    
    func addWorkout(workout : Workout) -> Bool {
        return model.addWorkout(newWorkout: workout)
    }
    
    func removeWorkout(index : Int) {
        model.removeWorkout(index: index)
    }
    
    func getWorkout(name : String) -> Workout? {
        let workout = model.getWorkout(name: name)
        return workout
    }
}
