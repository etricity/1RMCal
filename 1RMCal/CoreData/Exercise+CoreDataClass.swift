//
//  Exercise+CoreDataClass.swift
//  
//
//  Created by Isaiah Cuzzupe on 4/1/21.
//
//

import Foundation
import CoreData

@objc(Exercise)
public class Exercise: NSManagedObject {
    
    // Get instance by index
    
    func addInstance(instance : ExerciseInstance) {
        self.addToInstances(instance)
    }
    
    func getInstance(index : Int) -> ExerciseInstance? {
        guard let instances : [ExerciseInstance] = self.instances?.allObjects as? [ExerciseInstance] else {return nil}
        guard let instance : ExerciseInstance = instances[safe: index] else {return nil}
        return instance
    }
    
    func removeInstance(index : Int) {
        guard let instances : [ExerciseInstance] = self.instances?.allObjects as? [ExerciseInstance] else {return}
        guard let instance : ExerciseInstance = instances[safe: index] else {return}
    }
    
}
