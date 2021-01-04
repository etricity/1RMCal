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
        self.updateBestSet(instance: instance)
    }
    
    func getInstance(index : Int) -> ExerciseInstance? {
        guard let instances : [ExerciseInstance] = self.instances?.allObjects as? [ExerciseInstance] else {return nil}
        guard let instance : ExerciseInstance = instances[safe: index] else {return nil}
        return instance
    }
    
    func removeInstance(index : Int) {
        guard let instances : [ExerciseInstance] = self.instances?.allObjects as? [ExerciseInstance] else {return}
        guard let instance : ExerciseInstance = instances[safe: index] else {return}
        self.removeFromInstances(instance)
        let cd = CoreDataManager.shared
        cd.deleteObject(object: instance)
    }
    
    func updateBestSet(instance : ExerciseInstance) -> Bool {
        var updated : Bool = false

        if self.bestSet == nil , let instanceBestSet : SetStat = instance.bestSet {
            self.bestSet = instanceBestSet
        } else if let currentBestSet : SetStat = self.bestSet, let instanceBestSet : SetStat = instance.bestSet {
            if instanceBestSet.oneRM > currentBestSet.oneRM {
                self.bestSet = instance.bestSet
                updated = true
            }
        }
        return updated
    }
}
