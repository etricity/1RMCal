//
//  ExerciseCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 4/1/21.
//
//

import Foundation
import CoreData


extension ExerciseCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseCD> {
        return NSFetchRequest<ExerciseCD>(entityName: "ExerciseCD")
    }

    @NSManaged public var name: String
    @NSManaged public var bestSet: SetStat?
    @NSManaged public var instances: NSMutableOrderedSet

}

// MARK: Generated accessors for instances
extension ExerciseCD {

    @objc(insertObject:inInstancesAtIndex:)
    @NSManaged public func insertIntoInstances(_ value: ExerciseInstance, at idx: Int)

    @objc(removeObjectFromInstancesAtIndex:)
    @NSManaged public func removeFromInstances(at idx: Int)

    @objc(insertInstances:atIndexes:)
    @NSManaged public func insertIntoInstances(_ values: [ExerciseInstance], at indexes: NSIndexSet)

    @objc(removeInstancesAtIndexes:)
    @NSManaged public func removeFromInstances(at indexes: NSIndexSet)

    @objc(replaceObjectInInstancesAtIndex:withObject:)
    @NSManaged public func replaceInstances(at idx: Int, with value: ExerciseInstance)

    @objc(replaceInstancesAtIndexes:withInstances:)
    @NSManaged public func replaceInstances(at indexes: NSIndexSet, with values: [ExerciseInstance])

    @objc(addInstancesObject:)
    @NSManaged public func addToInstances(_ value: ExerciseInstance)

    @objc(removeInstancesObject:)
    @NSManaged public func removeFromInstances(_ value: ExerciseInstance)

    @objc(addInstances:)
    @NSManaged public func addToInstances(_ values: NSOrderedSet)

    @objc(removeInstances:)
    @NSManaged public func removeFromInstances(_ values: NSOrderedSet)

}
