//
//  WorkoutCD+CoreDataClass.swift
//  
//
//  Created by Isaiah Cuzzupe on 31/12/20.
//
//

import Foundation
import CoreData

@objc(WorkoutCD)
public class WorkoutCD: NSManagedObject {

    func getExercise(index : Int) -> ExerciseCD? {
        var exercise : ExerciseCD? = nil
        let exercises = self.exercises.array as! [ExerciseCD]
        if exercises.indices.contains(index) {
            exercise = exercises[index]
        }
        
        return exercise
    }
    
    func getInstance(index : Int) -> WorkoutInstanceCD? {
        var instance : WorkoutInstanceCD? = nil
        let instances = self.instances.array as! [WorkoutInstanceCD]
        if instances.indices.contains(index) {
            instance = instances[index]
        }
        
        return instance
    }
    
    func removeInstance(index : Int) {
        
        let instanceToRemove = self.getInstance(index: index)
        
        if instanceToRemove != nil {
            let instanceToRemove = self.getInstance(index: index)
            self.removeFromInstances(at: index)
            let cd = CoreDataManager.shared
            cd.managedContext.delete(instanceToRemove!)
            cd.saveData()
        }
    }
    
}
