//
//  ExerciseInstanceCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 31/12/20.
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
    @NSManaged public var sets: NSSet?
    @NSManaged public var bestSet: SetStatCD?

}

// MARK: Generated accessors for sets
extension ExerciseInstanceCD {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: SetStatCD)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: SetStatCD)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}
