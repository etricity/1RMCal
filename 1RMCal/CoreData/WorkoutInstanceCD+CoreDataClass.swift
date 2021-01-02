//
//  WorkoutInstanceCD+CoreDataClass.swift
//  
//
//  Created by Isaiah Cuzzupe on 31/12/20.
//
//

import Foundation
import CoreData

@objc(WorkoutInstanceCD)
public class WorkoutInstanceCD: NSManagedObject {
        
    func getExerciseInstance(index : Int) -> ExerciseInstanceCD? {
        var instance : ExerciseInstanceCD? = nil
        let instances = self.exerciseInstances.array as! [ExerciseInstanceCD]
        if instances.indices.contains(index) {
            instance = instances[index]
        }
        return instance
    }
    
}
