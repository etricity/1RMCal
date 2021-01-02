//
//  WorkoutCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 2/1/21.
//
//

import Foundation
import CoreData


extension WorkoutCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutCD> {
        return NSFetchRequest<WorkoutCD>(entityName: "WorkoutCD")
    }

    @NSManaged public var name: String
    @NSManaged public var workoutInstances: NSMutableOrderedSet?

}

// MARK: Generated accessors for workoutInstances
extension WorkoutCD {

    @objc(insertObject:inWorkoutInstancesAtIndex:)
    @NSManaged public func insertIntoWorkoutInstances(_ value: WorkoutInstanceCD, at idx: Int)

    @objc(removeObjectFromWorkoutInstancesAtIndex:)
    @NSManaged public func removeFromWorkoutInstances(at idx: Int)

    @objc(insertWorkoutInstances:atIndexes:)
    @NSManaged public func insertIntoWorkoutInstances(_ values: [WorkoutInstanceCD], at indexes: NSIndexSet)

    @objc(removeWorkoutInstancesAtIndexes:)
    @NSManaged public func removeFromWorkoutInstances(at indexes: NSIndexSet)

    @objc(replaceObjectInWorkoutInstancesAtIndex:withObject:)
    @NSManaged public func replaceWorkoutInstances(at idx: Int, with value: WorkoutInstanceCD)

    @objc(replaceWorkoutInstancesAtIndexes:withWorkoutInstances:)
    @NSManaged public func replaceWorkoutInstances(at indexes: NSIndexSet, with values: [WorkoutInstanceCD])

    @objc(addWorkoutInstancesObject:)
    @NSManaged public func addToWorkoutInstances(_ value: WorkoutInstanceCD)

    @objc(removeWorkoutInstancesObject:)
    @NSManaged public func removeFromWorkoutInstances(_ value: WorkoutInstanceCD)

    @objc(addWorkoutInstances:)
    @NSManaged public func addToWorkoutInstances(_ values: NSOrderedSet)

    @objc(removeWorkoutInstances:)
    @NSManaged public func removeFromWorkoutInstances(_ values: NSOrderedSet)

}
