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
        NotificationCenter.default.addObserver(self, selector: #selector(saveData(_:)), name: .saveData, object: nil)
    }
    
    
    // Getters
    func getExercises() -> [Exercise]? {
        
        var exercises : [Exercise]? = nil
        
        do {
            let fectchRequest : NSFetchRequest<Exercise> = Exercise.fetchRequest()
            exercises = try managedContext.fetch(fectchRequest)
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
        return exercises
    }
    
    func getWorkouts() {
        
    }
    
    
    // Model Creation Functions
    
    //Create SetStat
    func createSetStat(weight : Double, repCount : Double, unitString : String) -> SetStat {
        let setStatEntity = NSEntityDescription.entity(forEntityName: "SetStat", in: managedContext)!
        let setStat = NSManagedObject(entity: setStatEntity, insertInto: managedContext) as! SetStat

        setStat.weight = weight
        setStat.repCount = repCount
        setStat.unitString = unitString
        setStat.exerciseInstance = nil
        setStat.exercise = nil
        return setStat
    }
    
    //Create ExerciseInstance
    func createExerciseInstance(name : String, sets : [SetStat]) -> ExerciseInstance {
        let exerciseInstanceEntity = NSEntityDescription.entity(forEntityName: "ExerciseInstance", in: managedContext)!
        let exerciseInstance = NSManagedObject(entity: exerciseInstanceEntity, insertInto: managedContext) as! ExerciseInstance

    
        exerciseInstance.name = name
        
        for set in sets {
            set.exerciseInstance = exerciseInstance
            exerciseInstance.addToSets(set)
        }
        exerciseInstance.exercise = nil
        exerciseInstance.date = Date()

        
        return exerciseInstance
    }
    
    //Create Exercise
    func createExercise(name : String) -> Exercise {
        let exerciseEntity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)!
        let exercise = NSManagedObject(entity: exerciseEntity, insertInto: managedContext) as! Exercise
        
        exercise.name = name
        exercise.bestSet = nil
        exercise.instances = nil
        
        return exercise
    }
    

    //Create WorkoutInstance
    private func createWorkoutInstance(name : String) -> WorkoutInstanceCD {
        let workoutInstanceEntity = NSEntityDescription.entity(forEntityName: "WorkoutInstanceCD", in: managedContext)!
        let workoutInstance = NSManagedObject(entity: workoutInstanceEntity, insertInto: managedContext) as! WorkoutInstanceCD

        workoutInstance.name = name
        workoutInstance.date = Date()
        
        return workoutInstance
    }
    
    //Create Workout
    private func createWorkout(name : String) -> WorkoutCD {
        let workoutEntity = NSEntityDescription.entity(forEntityName: "WorkoutCD", in: managedContext)!
        let workout = NSManagedObject(entity: workoutEntity, insertInto: managedContext) as! WorkoutCD

        workout.name = name
        workout.date = Date()
        
        return workout
    }
    
    //Load, Save & Delete functionality
    
    // Add exercise to Workout
    @objc func saveData(_ notification:Notification) {
        self.saveData()
    }
    
    func saveData() {
    
        //Save to CoreData
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func testData() {
        do {
            

                    
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
    }

    func loadData() {
        
        //Requests for CurrentWeather, DailyWeather, WeeklyWeather
        do {
            
            let exercise = createExercise(name: "Bench Press")
            self.saveData()
            
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
    }
    
    func deleteCoreData() {
        deleteData("SetStat")
        deleteData("ExerciseInstance")
        deleteData("Exercise")

        deleteData("WorkoutInstanceCD")
        deleteData("WorkoutCD")
    }
    
    func deleteObject(object : NSManagedObject) {
        managedContext.delete(object)
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
