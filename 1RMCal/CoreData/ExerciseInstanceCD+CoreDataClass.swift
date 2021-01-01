//
//  ExerciseInstanceCD+CoreDataClass.swift
//  
//
//  Created by Isaiah Cuzzupe on 31/12/20.
//
//

import Foundation
import CoreData

@objc(ExerciseInstanceCD)
public class ExerciseInstanceCD: NSManagedObject {

    var bestSet : SetStatCD? {
        return self.sets?.max(by: { (a,b) in (a ).oneRM < (b).oneRM }) ?? nil
    }
    
}
