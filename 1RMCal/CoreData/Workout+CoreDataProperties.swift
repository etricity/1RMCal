//
//  Workout+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 5/1/21.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var name: String
    @NSManaged public var instances: NSMutableOrderedSet?
    @NSManaged public var exercises: NSMutableOrderedSet?

}

// MARK: Generated accessors for instances
extension Workout {

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

// MARK: Generated accessors for exercises
extension Workout {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}
