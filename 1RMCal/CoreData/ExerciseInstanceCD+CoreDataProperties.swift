//
//  ExerciseInstanceCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 1/1/21.
//
//

import Foundation
import CoreData


extension ExerciseInstanceCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseInstanceCD> {
        return NSFetchRequest<ExerciseInstanceCD>(entityName: "ExerciseInstanceCD")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var sets: NSMutableOrderedSet

}
