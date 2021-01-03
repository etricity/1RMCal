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
    
    func addInstance(instance : WorkoutInstanceCD) {
        self.insertIntoInstances(instance, at: 0)
    }
    
    func removeInstance(index : Int) {
        
        let instanceToRemove = self.getInstance(index: index)
        
        if instanceToRemove != nil {
            self.removeFromInstances(at: index)
            let cd = CoreDataManager.shared
            cd.managedContext.delete(instanceToRemove!)
            cd.saveData()
        }
    }
    
    func removeExercise(index : Int) {
        
        let exerciseToRemove = self.getExercise(index: index)
        
        if exerciseToRemove != nil {
            self.removeFromExercises(at: index)
            let cd = CoreDataManager.shared
            cd.managedContext.delete(exerciseToRemove!)
            cd.saveData()
        }
    }
    
}
