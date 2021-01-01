//
//  ExerciseManagerCD+CoreDataClass.swift
//  
//
//  Created by Isaiah Cuzzupe on 31/12/20.
//
//

import Foundation
import CoreData

@objc(ExerciseManagerCD)
public class ExerciseManagerCD: NSManagedObject {
    
    func canAddExercise(name : String) -> Bool {
        let exercises = self.exercises.array as! [ExerciseCD]
        return  exercises.contains { exercise in
            return exercise.name.lowercased() == name.lowercased()
        }
    }
    
    func swapExercises(x : Int, y : Int) {
        let validIndices = 0...exercises.count - 1
        if validIndices.contains(x) && validIndices.contains(y) {
            self.exercises.exchangeObject(at: x, withObjectAt: y)
        }
    }
    
    func getExercise(index : Int) -> ExerciseCD? {
        
        let lowerBound = 0
        let upperBound = self.exercises.count - 1
        
        if (lowerBound...upperBound).contains(index) {
            return self.exercises[index] as! ExerciseCD
        }
        return nil
    }    
}

// Add new exercise
//func addExercise(name : String) -> Bool {
//
//    let exerciseExists = exercises.contains { exercise in
//        return exercise.name.lowercased() == name.lowercased()
//    }
//
//    if !exerciseExists {
//        self.exercises.append(Exercise(name: name, current1RM: 0))
//        return true
//    } else {
//        return false
//    }
//}
////test purposes only
//func addExercise(exercise : Exercise) {
//    self.exercises.append(exercise)
//}
//
//// Remove exercise
//func removeExercise(index : Int) {
//
//    if self.exercises.indices.contains(index) {
//        self.exercises.remove(at: index)
//    }
//}
//
