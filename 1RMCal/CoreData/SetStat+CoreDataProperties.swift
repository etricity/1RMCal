//
//  SetStat+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 4/1/21.
//
//

import Foundation
import CoreData


extension SetStat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SetStat> {
        return NSFetchRequest<SetStat>(entityName: "SetStat")
    }

    @NSManaged public var repCount: Double
    @NSManaged public var unitString: String
    @NSManaged public var weight: Double
    @NSManaged public var exerciseInstance: ExerciseInstance?
    @NSManaged public var exercise: Exercise?

}

