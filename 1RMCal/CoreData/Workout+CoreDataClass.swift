//
//  Workout+CoreDataClass.swift
//  
//
//  Created by Isaiah Cuzzupe on 5/1/21.
//
//

import Foundation
import CoreData

@objc(Workout)
public class Workout: NSManagedObject {

    func getInstance(index : Int) -> WorkoutInstance? {
        guard let instances : [WorkoutInstance] = self.instances?.allObjects as? [WorkoutInstance] else {return nil}
        guard let instance : WorkoutInstance = instances[safe: index] else {return nil}
        return instance
    }
    
    func removeInstance(instance : WorkoutInstance) {
        self.removeFromInstances(instance)
    }
    
    func getExercise(index : Int) -> Exercise? {
        guard let workoutExercises : [Exercise] = self.exercises?.allObjects as? [Exercise] else {return nil}
        guard let exercise : Exercise = workoutExercises[safe: index] else {return nil}
        return exercise
    }

    
}
