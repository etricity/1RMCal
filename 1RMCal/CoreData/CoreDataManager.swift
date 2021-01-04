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
    func createSetStat(weight : Double, repCount : Double, unitString : String) -> SetStat {
        let setStatEntity = NSEntityDescription.entity(forEntityName: "SetStat", in: managedContext)!
        let setStat = NSManagedObject(entity: setStatEntity, insertInto: managedContext) as! SetStat

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
    

    //Create WorkoutInstance
    private func createWorkoutInstance(name : String) -> WorkoutInstanceCD {
        let workoutInstanceEntity = NSEntityDescription.entity(forEntityName: "WorkoutInstanceCD", in: managedContext)!
        let workoutInstance = NSManagedObject(entity: workoutInstanceEntity, insertInto: managedContext) as! WorkoutInstanceCD

        workoutInstance.name = name
        workoutInstance.exerciseInstances = []
        workoutInstance.date = Date()
        
        return workoutInstance
    }
    
    //Create Workout
    private func createWorkout(name : String) -> WorkoutCD {
        let workoutEntity = NSEntityDescription.entity(forEntityName: "WorkoutCD", in: managedContext)!
        let workout = NSManagedObject(entity: workoutEntity, insertInto: managedContext) as! WorkoutCD

        workout.name = name
        workout.instances = []
        workout.date = Date()
        
        return workout
    }
    
    //Load, Save & Delete functionality
    
    func saveData() {
        deleteCoreData()
        
        let workout = createWorkout(name: "Compound Exercises")
//        let exerciseManager = createExerciseManager()
        let exercise = createExercise(name: "Bench Press")
        let exercise2 = createExercise(name: "Deadlift")
        let exerciseInstance = createExerciseInstance(name: exercise.name)
        let workoutInstance = createWorkoutInstance(name: workout.name)
        let setStat = createSetStat(weight: 70, repCount: 12, unitString: Weight.kg.rawValue)
        
        
        
        //Save to CoreData
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func testData() {
        do {
            
            // Fetch Requests
            let fectchRequestSS : NSFetchRequest<SetStat> = SetStat.fetchRequest()

            
            // Core Data Models
            let setStats = try managedContext.fetch(fectchRequestSS)
            let setStat = setStats.first
            
            if let set = setStat {
                print(set.summary)
            }

        
            
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
    }

    func loadData() {
        
        //Requests for CurrentWeather, DailyWeather, WeeklyWeather
        do {
            
            // Fetch Requests
            let fectchRequestSS : NSFetchRequest<SetStat> = SetStat.fetchRequest()
            let fectchRequestExIn : NSFetchRequest<ExerciseInstanceCD> = ExerciseInstanceCD.fetchRequest()
            let fectchRequestEx : NSFetchRequest<ExerciseCD> = ExerciseCD.fetchRequest()
            let fectchRequestWorkIn : NSFetchRequest<WorkoutInstanceCD> = WorkoutInstanceCD.fetchRequest()
            let fectchRequestWork : NSFetchRequest<WorkoutCD> = WorkoutCD.fetchRequest()
            
            // Core Data Models
            let setStat = try managedContext.fetch(fectchRequestSS) as! [SetStat]
            let exerciseInstances = try managedContext.fetch(fectchRequestExIn) as! [ExerciseInstanceCD]
            let exercises = try managedContext.fetch(fectchRequestEx) as! [ExerciseCD]
//            let exerciseManagers = try managedContext.fetch(fectchRequestExMan) as! [ExerciseManagerCD]
            let workoutInstances = try managedContext.fetch(fectchRequestWorkIn) as! [WorkoutInstanceCD]
            let workouts = try managedContext.fetch(fectchRequestWork) as! [WorkoutCD]
            
            // Extract neccessary elements
            let workout = workouts.first
            let workoutInstance = workoutInstances.first
//            let exerciseManager = exerciseManagers.first
            let exercise = exercises.first

        
            
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
    }
    
    func deleteCoreData() {
        deleteData("SetStat")
        deleteData("ExerciseInstanceCD")
        deleteData("ExerciseCD")

        deleteData("WorkoutInstanceCD")
        deleteData("WorkoutCD")
    }
    
    //Erase all entities in CoreData
    private func deleteData(_ entity:String) {
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
