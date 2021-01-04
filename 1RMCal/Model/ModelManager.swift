//
//  ModelManager.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 4/1/21.
//  Copyright © 2021 Isaiah Cuzzupe. All rights reserved.
//

import Foundation

class ModelManager1 {
    
    let cd = CoreDataManager.shared
    
    var exercises : [Exercise]? {
        return cd.getExercises()
    }
    
    // Get exercise by index
    
    func getExercise(index : Int) -> Exercise? {
        guard let exercise = exercises?[safe: index] else {return nil}
        return exercise
    }
    
    func addExercise(name : String) {
        cd.createExercise(name: name)
    }
    
    func removeExercise(index : Int) {
        guard let exercise = exercises?[safe: index] else {return}
        cd.deleteObject(object: exercise)
    }
    
}
