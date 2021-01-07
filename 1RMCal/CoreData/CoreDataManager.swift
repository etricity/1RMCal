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
    func createExerciseInstance(exercise : Exercise, sets : [SetStat], date : Date = Date()) -> ExerciseInstance {
        let exerciseInstanceEntity = NSEntityDescription.entity(forEntityName: "ExerciseInstance", in: managedContext)!
        let exerciseInstance = NSManagedObject(entity: exerciseInstanceEntity, insertInto: managedContext) as! ExerciseInstance

    
        exerciseInstance.name = exercise.name
        
        for set in sets {
            set.exerciseInstance = exerciseInstance
            exerciseInstance.addToSets(set)
        }
        exerciseInstance.exercise = exercise
        exerciseInstance.workoutInstance = nil
        exerciseInstance.date = date

        
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
    func createWorkoutInstance(workout : Workout, exerciseInstances : [ExerciseInstance], date : Date = Date()) -> WorkoutInstance {
        let workoutInstanceEntity = NSEntityDescription.entity(forEntityName: "WorkoutInstance", in: managedContext)!
        let workoutInstance = NSManagedObject(entity: workoutInstanceEntity, insertInto: managedContext) as! WorkoutInstance

        workoutInstance.name = workout.name
        workoutInstance.date = date
        
        for instance in exerciseInstances {
            instance.workoutInstance = workoutInstance
            workoutInstance.addToExerciseInstances(instance)
        }
        workoutInstance.workout = workout
        
        return workoutInstance
    }
    
    //Create Workout
    func createWorkout(name : String, exercises : [Exercise]) -> Workout {
        let workoutEntity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)!
        let workout = NSManagedObject(entity: workoutEntity, insertInto: managedContext) as! Workout

        workout.name = name
        workout.instances = nil
        
        for exercise in exercises {
            exercise.addToWorkout(workout)
            workout.addToExercises(exercise)
        }
        return workout
    }
    
    //Load, Save & Delete functionality
    
    func loadData() {
        
        // exercises
        let benchPress = createExercise(name: "Bench Press")
        let bbRow = createExercise(name: "BB Row")
        let inclineBP = createExercise(name: "Incline Bench Press")
        let chinUps = createExercise(name: "Chin Ups")
        let declineBP = createExercise(name: "Decline Bench Press")
        let latMachine = createExercise(name: "Lat Machine")
        let pecDeck = createExercise(name: "Pec Deck")
        let pushUps = createExercise(name: "Push Ups")
        let absMachine = createExercise(name: "AB Machine (straight)")
        
        var exercises : [Exercise] = []
        exercises.append(benchPress)
        exercises.append(bbRow)
        exercises.append(inclineBP)
        exercises.append(chinUps)
        exercises.append(declineBP)
        exercises.append(latMachine)
        exercises.append(pecDeck)
        exercises.append(pushUps)
        exercises.append(absMachine)
        
        // exercise instances
        let date1 = Date(timeIntervalSince1970: 1609750800)
        let bps1 = createSetStat(weight: 74.5, repCount: 12, unitString: Weight.kg.rawValue)
        let bps2 = createSetStat(weight: 83.5, repCount: 9, unitString: Weight.kg.rawValue)
        let bps3 = createSetStat(weight: 88, repCount: 8, unitString: Weight.kg.rawValue)
        let bpInst = createExerciseInstance(exercise: benchPress, sets: [bps1, bps2, bps3], date: date1)
    
        
        let bbs1 = createSetStat(weight: 80, repCount: 12, unitString: Weight.kg.rawValue)
        let bbs2 = createSetStat(weight: 80, repCount: 12, unitString: Weight.kg.rawValue)
        let bbs3 = createSetStat(weight: 90, repCount: 9, unitString: Weight.kg.rawValue)
        let bbInst = createExerciseInstance(exercise: bbRow, sets: [bbs1, bbs2, bbs3], date: date1)
        
        let ins1 = createSetStat(weight: 70, repCount: 8, unitString: Weight.kg.rawValue)
        let ins2 = createSetStat(weight: 70, repCount: 8, unitString: Weight.kg.rawValue)
        let ins3 = createSetStat(weight: 70, repCount: 8, unitString: Weight.kg.rawValue)
        let inInst = createExerciseInstance(exercise: inclineBP, sets: [ins1, ins2, ins3], date: date1)
        
        let chin1 = createSetStat(weight: 70, repCount: 16, unitString: Weight.kg.rawValue)
        let chin2 = createSetStat(weight: 70, repCount: 11, unitString: Weight.kg.rawValue)
        let chin3 = createSetStat(weight: 70, repCount: 12, unitString: Weight.kg.rawValue)
        let chinIst = createExerciseInstance(exercise: chinUps, sets: [chin1, chin2, chin3], date: date1)
        
        let dec1 = createSetStat(weight: 83.5, repCount: 16, unitString: Weight.kg.rawValue)
        let dec2 = createSetStat(weight: 83.5, repCount: 11, unitString: Weight.kg.rawValue)
        let dec3 = createSetStat(weight: 83.5, repCount: 12, unitString: Weight.kg.rawValue)
        let decInst = createExerciseInstance(exercise: declineBP, sets: [dec1, dec2, dec3], date: date1)
        
        let latM1 = createSetStat(weight: 81.5, repCount: 11, unitString: Weight.kg.rawValue)
        let latM2 = createSetStat(weight: 81.5, repCount: 8, unitString: Weight.kg.rawValue)
        let latM3 = createSetStat(weight: 81.5, repCount: 7, unitString: Weight.kg.rawValue)
        let latM = createExerciseInstance(exercise: latMachine, sets: [latM1, latM2, latM3], date: date1)
        
        let pec1 = createSetStat(weight: 50, repCount: 9, unitString: Weight.kg.rawValue)
        let pec2 = createSetStat(weight: 50, repCount: 8, unitString: Weight.kg.rawValue)
        let pec3 = createSetStat(weight: 50, repCount: 7, unitString: Weight.kg.rawValue)
        let pec = createExerciseInstance(exercise: pecDeck, sets: [pec1, pec2, pec3], date: date1)
        
        let push1 = createSetStat(weight: 0, repCount: 10, unitString: Weight.kg.rawValue)
        let push2 = createSetStat(weight: 0, repCount: 10, unitString: Weight.kg.rawValue)
        let push3 = createSetStat(weight: 0, repCount: 10, unitString: Weight.kg.rawValue)
        let push = createExerciseInstance(exercise: pushUps, sets: [push1, push2, push3], date: date1)
        
        let ab1 = createSetStat(weight: 120, repCount: 20, unitString: Weight.kg.rawValue)
        let ab2 = createSetStat(weight: 120, repCount: 18, unitString: Weight.kg.rawValue)
        let ab3 = createSetStat(weight: 120, repCount: 16, unitString: Weight.kg.rawValue)
        let ab = createExerciseInstance(exercise: absMachine, sets: [ab1, ab2, ab3], date: date1)

    
        
        // exercises Instances
        var exerciseInstances : [ExerciseInstance] = []
        exerciseInstances.append(bpInst)
        exerciseInstances.append(bbInst)
        exerciseInstances.append(inInst)
        exerciseInstances.append(chinIst)
        exerciseInstances.append(decInst)
        exerciseInstances.append(latM)
        exerciseInstances.append(pec)
        exerciseInstances.append(push)
        exerciseInstances.append(ab)
        
    
        // workout
        let jan2021 = createWorkout(name: "Jan 2021", exercises: exercises)
        
        // workout instance
        let workoutInst = createWorkoutInstance(workout: jan2021, exerciseInstances: exerciseInstances, date: date1)
        jan2021.addToInstances(workoutInst)
    }
    
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
