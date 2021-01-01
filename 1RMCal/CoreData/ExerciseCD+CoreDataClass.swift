//
//  ExerciseCD+CoreDataClass.swift
//  
//
//  Created by Isaiah Cuzzupe on 31/12/20.
//
//

import Foundation
import CoreData

@objc(ExerciseCD)
public class ExerciseCD: NSManagedObject {
    
    var current1RM : Double {
        self.bestSet?.oneRM ?? 0
    }
    
    func addNewInstance(instance : ExerciseInstanceCD) {
        self.addToInstances(instance)
        self.updateBestSet(instance: instance)
    }
    
    func updateBestSet(instance : ExerciseInstanceCD) -> Bool {
        var updated : Bool = false
        let current1RM : Double = instance.bestSet?.oneRM ?? 0
        let setBest1RM : Double = self.bestSet?.oneRM ?? 0
        
        if current1RM > setBest1RM {
            self.bestSet = instance.bestSet
        }
        
           return updated
       }

}
