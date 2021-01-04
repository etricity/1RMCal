//
//  ExerciseInstance+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 4/1/21.
//
//

import Foundation
import CoreData


extension ExerciseInstance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseInstance> {
        return NSFetchRequest<ExerciseInstance>(entityName: "ExerciseInstance")
    }

    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var sets: NSOrderedSet
    @NSManaged public var exercise: Exercise?

}

// MARK: Generated accessors for sets
extension ExerciseInstance {

    @objc(insertObject:inSetsAtIndex:)
    @NSManaged public func insertIntoSets(_ value: SetStat, at idx: Int)

    @objc(removeObjectFromSetsAtIndex:)
    @NSManaged public func removeFromSets(at idx: Int)

    @objc(insertSets:atIndexes:)
    @NSManaged public func insertIntoSets(_ values: [SetStat], at indexes: NSIndexSet)

    @objc(removeSetsAtIndexes:)
    @NSManaged public func removeFromSets(at indexes: NSIndexSet)

    @objc(replaceObjectInSetsAtIndex:withObject:)
    @NSManaged public func replaceSets(at idx: Int, with value: SetStat)

    @objc(replaceSetsAtIndexes:withSets:)
    @NSManaged public func replaceSets(at indexes: NSIndexSet, with values: [SetStat])

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: SetStat)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: SetStat)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSOrderedSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSOrderedSet)

}
