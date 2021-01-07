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
        guard let instance : WorkoutInstance = self.instances?.object(at: index) as? WorkoutInstance else {return nil}
        return instance
    }
    
    func removeInstance(instance : WorkoutInstance) {
        self.removeFromInstances(instance)
    }
    
    func getExercise(index : Int) -> Exercise? {
        guard let exercise : Exercise = self.exercises?.object(at: index) as? Exercise else {return nil}
        return exercise
    }

    
}
