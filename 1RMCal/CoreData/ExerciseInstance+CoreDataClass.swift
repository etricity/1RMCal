//
//  ExerciseInstance+CoreDataClass.swift
//
//
//  Created by Isaiah Cuzzupe on 31/12/20.
//
//

import Foundation
import CoreData

@objc(ExerciseInstance)
public class ExerciseInstance: NSManagedObject {

    var bestSet : SetStat? {
        let sets = self.sets.array as! Array<SetStat>
        return sets.max(by: { (a,b) in (a ).oneRM < (b).oneRM }) ?? nil
    }
    
    func addToSets(set : SetStat) {
        self.addToSets(set)
    }
    
}
