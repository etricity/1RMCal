//
//  ModelManager.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 19/9/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/*
 
    This class interacts with CoreData and is responibile for saving, deleting & retreiving data
 
 */

class CoreDataManager{
    static let shared = CoreDataManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext : NSManagedObjectContext
        
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    //Create SetStat
    private func createSetStat(weight : Double, repCount : Double, unitString : String) -> SetStatCD {
        let setStatEntity = NSEntityDescription.entity(forEntityName: "SetStatCD", in: managedContext)!
        let setStat = NSManagedObject(entity: setStatEntity, insertInto: managedContext) as! SetStatCD

        setStat.weight = weight
        setStat.repCount = repCount
        setStat.unitString = unitString
    
        return setStat
    }
    
    //Create ExerciseInstance
    private func createExerciseInstance(name : String) -> ExerciseInstanceCD {
        let exerciseInstanceEntity = NSEntityDescription.entity(forEntityName: "ExerciseInstanceCD", in: managedContext)!
        let exerciseInstance = NSManagedObject(entity: exerciseInstanceEntity, insertInto: managedContext) as! ExerciseInstanceCD

        exerciseInstance.name = name
        exerciseInstance.sets = []
        exerciseInstance.date = Date()
        
        return exerciseInstance
    }
    
    //Create Exercise
    private func createExercise(name : String) -> ExerciseCD {
        let exerciseEntity = NSEntityDescription.entity(forEntityName: "ExerciseCD", in: managedContext)!
        let exercise = NSManagedObject(entity: exerciseEntity, insertInto: managedContext) as! ExerciseCD

        exercise.name = name
        exercise.instances = []
        
        return exercise
    }
    
    //Load, Save & Delete functionality
    
    func saveData() {
        deleteAllData("SetStatCD")
        deleteAllData("ExerciseInstanceCD")
        deleteAllData("ExerciseCD")
        
        let exercise = createExercise(name: "Bench Press")
        let exerciseInstance = createExerciseInstance(name: exercise.name)
        let setStat = createSetStat(weight: 70, repCount: 12, unitString: Weight.kg.rawValue)
        
        exerciseInstance.addToSets(set: setStat)
        exercise.addNewInstance(instance: exerciseInstance)
        
        
        print(exerciseInstance.sets.count)
        print(exercise.current1RM)
        
        
        //Save to CoreData
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    func loadData() {
        
        //Requests for CurrentWeather, DailyWeather, WeeklyWeather
        do {
            
            let fectchRequestSS : NSFetchRequest<SetStatCD> = SetStatCD.fetchRequest()
            let fectchRequestExIn : NSFetchRequest<ExerciseInstanceCD> = ExerciseInstanceCD.fetchRequest()
            let fectchRequestEx : NSFetchRequest<ExerciseCD> = ExerciseCD.fetchRequest()
            
            let setStat = try managedContext.fetch(fectchRequestSS) as! [SetStatCD]
            let exerciseInstances = try managedContext.fetch(fectchRequestExIn) as! [ExerciseInstanceCD]
            let exercises = try managedContext.fetch(fectchRequestEx) as! [ExerciseCD]
            
            let exercise = exercises.first
            print(exercise?.instances.count)
            
            print(exerciseInstances.first?.sets.count)
            print(exercises.first?.current1RM)
            
            
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
    }
    
    //Erase all entities in CoreData
    private func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }

        
}
