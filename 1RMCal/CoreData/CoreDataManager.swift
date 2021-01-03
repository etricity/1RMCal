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
        // Add notification observer
        managedContext = appDelegate.persistentContainer.viewContext
        NotificationCenter.default.addObserver(self, selector: #selector(saveData(_:)), name: .addExerciseToWorkout, object: nil)
    }
    
    // Model Getters
    
    // Get all workouts
    func getWorkouts() -> [WorkoutCD]? {
        var workouts : [WorkoutCD]? = nil
        do {
            let fectchRequest : NSFetchRequest<WorkoutCD> = WorkoutCD.fetchRequest()
            workouts = try managedContext.fetch(fectchRequest)
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
        return workouts
    }
    
    // Get workouts exercises
    func getExercises() -> [ExerciseCD]? {
        var exercises : [ExerciseCD]? = nil
        do {
            let fectchRequest : NSFetchRequest<ExerciseCD> = ExerciseCD.fetchRequest()
            exercises = try managedContext.fetch(fectchRequest)
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
        return exercises
    }
    
    
    
    // Core Data Entity Creation
    
    //Create SetStat
    func createSetStat(weight : Double, repCount : Double, unitString : String) -> SetStatCD {
        let setStatEntity = NSEntityDescription.entity(forEntityName: "SetStatCD", in: managedContext)!
        let setStat = NSManagedObject(entity: setStatEntity, insertInto: managedContext) as! SetStatCD

        setStat.weight = weight
        setStat.repCount = repCount
        setStat.unitString = unitString
    
        return setStat
    }
    
    //Create ExerciseInstance
    func createExerciseInstance(name : String) -> ExerciseInstanceCD {
        let exerciseInstanceEntity = NSEntityDescription.entity(forEntityName: "ExerciseInstanceCD", in: managedContext)!
        let exerciseInstance = NSManagedObject(entity: exerciseInstanceEntity, insertInto: managedContext) as! ExerciseInstanceCD

        exerciseInstance.name = name
        exerciseInstance.sets = []
        exerciseInstance.date = Date()
        
        return exerciseInstance
    }
    
    //Create Exercise
    func createExercise(name : String) -> ExerciseCD {
        let exerciseEntity = NSEntityDescription.entity(forEntityName: "ExerciseCD", in: managedContext)!
        let exercise = NSManagedObject(entity: exerciseEntity, insertInto: managedContext) as! ExerciseCD

        exercise.name = name
        exercise.instances = []
        
        return exercise
    }
    
    //Create ExerciseManager
    func createExerciseManager() -> ExerciseManagerCD {
        let exerciseManagerEntity = NSEntityDescription.entity(forEntityName: "ExerciseManagerCD", in: managedContext)!
        let exerciseManager = NSManagedObject(entity: exerciseManagerEntity, insertInto: managedContext) as! ExerciseManagerCD

        return exerciseManager
    }
    
    //Create WorkoutInstance
    func createWorkoutInstance(name : String) -> WorkoutInstanceCD {
        let workoutInstanceEntity = NSEntityDescription.entity(forEntityName: "WorkoutInstanceCD", in: managedContext)!
        let workoutInstance = NSManagedObject(entity: workoutInstanceEntity, insertInto: managedContext) as! WorkoutInstanceCD

        workoutInstance.name = name
        workoutInstance.exerciseInstances = []
        workoutInstance.date = Date()
        
        return workoutInstance
    }
    
    //Create Workout
    func createWorkout(tempWorkout : WorkoutTemp) -> WorkoutCD {
        let workoutEntity = NSEntityDescription.entity(forEntityName: "WorkoutCD", in: managedContext)!
        let workout = NSManagedObject(entity: workoutEntity, insertInto: managedContext) as! WorkoutCD

        workout.name = tempWorkout.name
        workout.exercises = NSOrderedSet(array: tempWorkout.exercises)
        workout.instances = []
        
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

    func addTestData(addData : Bool) {
        
        if addData {
            deleteCoreData()
            
            let exercises = createWorkout(tempWorkout: WorkoutTemp(name: "Compound Movements"))
            
            let benchPress = createExercise(name: "Bench Press")
            let squat = createExercise(name: "Squat")
            let deadlift = createExercise(name: "Deadlift")
            exercises.addToExercises(benchPress)
            // create exercise instance
            let benchInstance = createExerciseInstance(name: benchPress.name)
            let set1 = createSetStat(weight: 100, repCount: 10, unitString: Weight.kg.rawValue)
            let set2 = createSetStat(weight: 120, repCount: 8, unitString: Weight.kg.rawValue)
            let set3 = createSetStat(weight: 135, repCount: 7, unitString: Weight.kg.rawValue)
            
            benchInstance.addToSets(set: set1)
            benchInstance.addToSets(set: set2)
            benchInstance.addToSets(set: set3)
            
            // create workoutInstance
            let workoutInstance = createWorkoutInstance(name: exercises.name)
            
            //perform exercise instance
            workoutInstance.addToExerciseInstances(benchInstance)
            benchPress.addInstance(instance: benchInstance)
            
            exercises.addToInstances(workoutInstance)
            
            let exerciseManager = createExerciseManager()
            exerciseManager.addToExercises(benchPress)
            exerciseManager.addToExercises(squat)
            exerciseManager.addToExercises(deadlift)
            
            saveData()
        }
    }
    
    func deleteCoreData() {
        deleteData("SetStatCD")
        deleteData("ExerciseInstanceCD")
        deleteData("ExerciseCD")
        deleteData("ExerciseManagerCD")
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
