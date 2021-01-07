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
        guard let instances : [ExerciseInstance] = self.instances?.array as? [ExerciseInstance] else {return nil}
        guard let instance : ExerciseInstance = instances[safe: index] else {return nil}
        return instance
    }
    
    func removeInstance(instance : ExerciseInstance) {
        self.removeFromInstances(instance)
        self.updateBestSet()
    }
    
    // update when added new instance
    func updateBestSet(instance : ExerciseInstance) {
        if self.bestSet == nil , let instanceBestSet : SetStat = instance.bestSet {
            self.bestSet = instanceBestSet
        } else if let currentBestSet : SetStat = self.bestSet, let instanceBestSet : SetStat = instance.bestSet {
            if instanceBestSet.oneRM > currentBestSet.oneRM {
                self.bestSet = instance.bestSet
            }
        }
    }
    
    // update when deleting instance
    func updateBestSet() {
        guard let instances : [ExerciseInstance] = self.instances?.array as? [ExerciseInstance] else {return}
        
        if instances.count > 0 {
            for instance in instances {
                if let sets : [SetStat] = instance.sets.array as? [SetStat] {
                    self.bestSet = sets.max { (a, b) -> Bool in
                        a.oneRM > b.oneRM
                    }
                }
            }
        } else {
            bestSet = nil
        }
    }
}
