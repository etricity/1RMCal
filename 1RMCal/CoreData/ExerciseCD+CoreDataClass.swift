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
    
    let managedContext = CoreDataManager.shared.managedContext
    
    var current1RM : Double {
        self.bestSet?.oneRM ?? 0
    }
    
    func addInstance(instance : ExerciseInstanceCD) {
        self.addToInstances(instance)
    }
    
    func addInstance(instance : ExerciseInstance) {
        createExerciseInstance(tempInstance: instance)
        NotificationCenter.default.post(name: .saveData, object: nil, userInfo: nil)
        self.updateBestSet()
    }
    
    func getInstance(index : Int) -> ExerciseInstanceCD? {
        var instance : ExerciseInstanceCD? = nil
        let instances = self.instances.array as! [ExerciseInstanceCD]
        if instances.indices.contains(index) {
            instance = instances[index]
        }
        
        return instance
    }
    
    func removeInstance(instance : ExerciseInstanceCD) {
        self.removeFromInstances(instance)
    }
    
    func removeInstance(index : Int) {
        
        let instanceToRemove = self.getInstance(index: index)
        
        if instanceToRemove != nil {
            self.removeFromInstances(instanceToRemove!)
            let cd = CoreDataManager.shared
            cd.managedContext.delete(instanceToRemove!)
            cd.saveData()
        }
    }
    
    func updateBestSet() -> Bool {
        var updated : Bool = false
        
        for instance in instances.array as! [ExerciseInstanceCD] {
            if let val = (instance as! ExerciseInstanceCD).bestSet?.oneRM {
                if val > bestSet?.oneRM ?? 0 {
                    bestSet = instance.bestSet
                    updated = true
                }
            }
        }
           return updated
       }
    
    
    
    //Create ExerciseInstance
    func createExerciseInstance(tempInstance : ExerciseInstance) -> ExerciseInstanceCD {
        let exerciseInstanceEntity = NSEntityDescription.entity(forEntityName: "ExerciseInstanceCD", in: managedContext)!
        let exerciseInstance = NSManagedObject(entity: exerciseInstanceEntity, insertInto: managedContext) as! ExerciseInstanceCD

        exerciseInstance.name = tempInstance.name
        // create set
        exerciseInstance.sets = []
        for set in tempInstance.sets {
            exerciseInstance.addToSets(createSetStat(tempStat: set))
        }
        exerciseInstance.date = Date()
        
        return exerciseInstance
    }
    
    //Create SetStat
    func createSetStat(tempStat : SetStat) -> SetStatCD {
        let setStatEntity = NSEntityDescription.entity(forEntityName: "SetStatCD", in: managedContext)!
        let setStat = NSManagedObject(entity: setStatEntity, insertInto: managedContext) as! SetStatCD

        setStat.weight = tempStat.weight
        setStat.repCount = Double(tempStat.repCount)
        setStat.unitString = tempStat.units.rawValue
    
        return setStat
    }
}
