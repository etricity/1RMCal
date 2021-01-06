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
    
    // get all exercises
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
    
    
    // get all workouts
    func getWorkouts() -> [Workout]? {
        var workouts : [Workout]? = nil
        
        do {
            let fectchRequest : NSFetchRequest<Workout> = Workout.fetchRequest()
            workouts = try managedContext.fetch(fectchRequest)
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
        return workouts
    }
    
    
    // get a exercise
    func getExercise(name : String) -> Exercise? {
        var exercise : Exercise? = nil
        
        let exerciseFR : NSFetchRequest<Exercise> = Exercise.fetchRequest()
        exerciseFR.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let exercises = try managedContext.fetch(exerciseFR)
            
            if exercises.count == 1 {
                exercise = exercises.first
            }
            
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
        return exercise
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
        exerciseInstance.workoutInstance = nil
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
        exercise.workout = nil
        
        return exercise
    }
    

    //Create WorkoutInstance
    func createWorkoutInstance(name : String, exerciseInstances : [ExerciseInstance]) -> WorkoutInstance {
        let workoutInstanceEntity = NSEntityDescription.entity(forEntityName: "WorkoutInstance", in: managedContext)!
        let workoutInstance = NSManagedObject(entity: workoutInstanceEntity, insertInto: managedContext) as! WorkoutInstance

        workoutInstance.name = name
        workoutInstance.date = Date()
        
        for instance in exerciseInstances {
            instance.workoutInstance = workoutInstance
            workoutInstance.addToExerciseInstances(instance)
        }
        workoutInstance.workout = nil
        
        return workoutInstance
    }
    
    //Create Workout
    func createWorkout(name : String, exercises : [String]) -> Workout {
        let workoutEntity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)!
        let workout = NSManagedObject(entity: workoutEntity, insertInto: managedContext) as! Workout

        workout.name = name
        workout.instances = nil
        
        if let allExercises = self.getExercises() {
            for name in exercises {
                let exercise : Exercise? = {
                    return allExercises.filter { exercise in
                        return exercise.name == name
                      }
                }().first ?? nil
                
                if let exercise : Exercise = exercise {
                    exercise.addToWorkout(workout)
                    workout.addToExercises(exercise)
                }
            }
        }
        return workout
    }
    
    //Load, Save & Delete functionality
    
    // Notification for saving
    @objc func saveData(_ notification:Notification) {
        self.saveData()
    }
    
    //Save CoreData
    func saveData() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // Delete all data
    func deleteCoreData() {
        deleteData("SetStat")
        deleteData("ExerciseInstance")
        deleteData("Exercise")

        deleteData("WorkoutInstance")
        deleteData("Workout")
    }
    
    func deleteObject(object : NSManagedObject) {
        managedContext.delete(object)
    }
    
    //Erase all of a speicific entities in CoreData
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
    
    // Testing Data
    func testData() {
        
        let exercise = self.getExercise(name: "Bench Press")
        print(exercise?.name)
        
    }
}
