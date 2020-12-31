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

class ModelManager{
    static let shared = ModelManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext : NSManagedObjectContext
    
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    //Create NSCity object for CurrentWeather
    private func createSetStat(weight : Double, repCount : Int, unitString : String) -> SetStatCD {
        let setStatEntity = NSEntityDescription.entity(forEntityName: "SetStat", in: managedContext)!
        let setStat = NSManagedObject(entity: setStatEntity, insertInto: managedContext) as! SetStatCD

        setStat.weight = weight
        setStat.repCount = repCount
        setStat.unitString = unitString
    
        return setStat
    }
    
    //Load, Save & Delete functionality
    
        //Save Weather after API call is made
    func saveWeather() {

        //Save to CoreData
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    func loadWeather() {
        
        //Requests for CurrentWeather, DailyWeather, WeeklyWeather
        do {
            let fectchRequestCW = NSFetchRequest<NSFetchRequestResult>(entityName: "NSCurrentWeather")
            let fectchRequestDW = NSFetchRequest<NSFetchRequestResult>(entityName: "NSDailyWeather")
            let fectchRequestWW = NSFetchRequest<NSFetchRequestResult>(entityName: "NSWeeklyWeather")
            
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
    }
        
}
