//
//  WorkoutCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 4/1/21.
//
//

import Foundation
import CoreData


extension WorkoutCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutCD> {
        return NSFetchRequest<WorkoutCD>(entityName: "WorkoutCD")
    }

    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var instances: NSOrderedSet?

}

// MARK: Generated accessors for instances
extension WorkoutCD {

    @objc(insertObject:inInstancesAtIndex:)
    @NSManaged public func insertIntoInstances(_ value: WorkoutInstance, at idx: Int)

    @objc(removeObjectFromInstancesAtIndex:)
    @NSManaged public func removeFromInstances(at idx: Int)

    @objc(insertInstances:atIndexes:)
    @NSManaged public func insertIntoInstances(_ values: [WorkoutInstance], at indexes: NSIndexSet)

    @objc(removeInstancesAtIndexes:)
    @NSManaged public func removeFromInstances(at indexes: NSIndexSet)

    @objc(replaceObjectInInstancesAtIndex:withObject:)
    @NSManaged public func replaceInstances(at idx: Int, with value: WorkoutInstance)

    @objc(replaceInstancesAtIndexes:withInstances:)
    @NSManaged public func replaceInstances(at indexes: NSIndexSet, with values: [WorkoutInstance])

    @objc(addInstancesObject:)
    @NSManaged public func addToInstances(_ value: WorkoutInstance)

    @objc(removeInstancesObject:)
    @NSManaged public func removeFromInstances(_ value: WorkoutInstance)

    @objc(addInstances:)
    @NSManaged public func addToInstances(_ values: NSOrderedSet)

    @objc(removeInstances:)
    @NSManaged public func removeFromInstances(_ values: NSOrderedSet)

}
