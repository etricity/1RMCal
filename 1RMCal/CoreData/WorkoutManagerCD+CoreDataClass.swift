//
//  WorkoutManagerCD+CoreDataClass.swift
//  
//
//  Created by Isaiah Cuzzupe on 31/12/20.
//
//

import Foundation
import CoreData

@objc(WorkoutManagerCD)
public class WorkoutManagerCD: NSManagedObject {

    func removeWorkout(index : Int) {
        
        let workoutToRemove = self.getWorkout(index: index)
        
        if workoutToRemove != nil {
            self.removeWorkout(index: index)
            let cd = CoreDataManager.shared
            cd.managedContext.delete(workoutToRemove!)
            cd.saveData()
        }
    }
    
    func removeWorkout(workout : WorkoutCD) {
        self.removeFromWorkouts(workout)
    }
    
    func getWorkout(index : Int) -> WorkoutCD? {
        var workout : WorkoutCD? = nil
        let workouts = self.workouts?.allObjects as! [WorkoutCD]
        if workouts.indices.contains(index) {
            workout = workouts[index]
        }
        
        return workout
    }
    
}
