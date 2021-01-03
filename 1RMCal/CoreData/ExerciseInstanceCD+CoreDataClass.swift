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
        let sets = self.sets.array as! Array<SetStatCD>
        return sets.max(by: { (a,b) in (a ).oneRM < (b).oneRM }) ?? nil
    }
    
    func addToSets(set : SetStatCD) {
        self.addToSets(set)
    }
    
}
