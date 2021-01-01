//
//  ExerciseCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 1/1/21.
//
//

import Foundation
import CoreData


extension ExerciseCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseCD> {
        return NSFetchRequest<ExerciseCD>(entityName: "ExerciseCD")
    }

    @NSManaged public var name: String
    @NSManaged public var bestSet: SetStatCD?
    @NSManaged public var instances: NSMutableOrderedSet
}
