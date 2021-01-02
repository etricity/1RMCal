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
    
    func removeInstance(index : Int) {
        
        if (0...self.instances.count - 1).contains(index) {
            self.removeFromInstances(at: index)
        }
    }
    
}
