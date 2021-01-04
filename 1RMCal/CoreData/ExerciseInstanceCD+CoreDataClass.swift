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

    var bestSet : SetStat? {
        let sets = self.sets.array as! Array<SetStat>
        return sets.max(by: { (a,b) in (a ).oneRM < (b).oneRM }) ?? nil
    }
    
    func addToSets(set : SetStat) {
        self.addToSets(set)
    }
    
}
