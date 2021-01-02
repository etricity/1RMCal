//
//  ExerciseInstanceCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 2/1/21.
//
//

import Foundation
import CoreData


extension ExerciseInstanceCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseInstanceCD> {
        return NSFetchRequest<ExerciseInstanceCD>(entityName: "ExerciseInstanceCD")
    }

    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var sets: NSMutableOrderedSet

}

// MARK: Generated accessors for sets
extension ExerciseInstanceCD {

    @objc(insertObject:inSetsAtIndex:)
    @NSManaged public func insertIntoSets(_ value: SetStatCD, at idx: Int)

    @objc(removeObjectFromSetsAtIndex:)
    @NSManaged public func removeFromSets(at idx: Int)

    @objc(insertSets:atIndexes:)
    @NSManaged public func insertIntoSets(_ values: [SetStatCD], at indexes: NSIndexSet)

    @objc(removeSetsAtIndexes:)
    @NSManaged public func removeFromSets(at indexes: NSIndexSet)

    @objc(replaceObjectInSetsAtIndex:withObject:)
    @NSManaged public func replaceSets(at idx: Int, with value: SetStatCD)

    @objc(replaceSetsAtIndexes:withSets:)
    @NSManaged public func replaceSets(at indexes: NSIndexSet, with values: [SetStatCD])

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: SetStatCD)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: SetStatCD)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSOrderedSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSOrderedSet)

}
