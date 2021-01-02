//
//  WorkoutInstanceCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 2/1/21.
//
//

import Foundation
import CoreData


extension WorkoutInstanceCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutInstanceCD> {
        return NSFetchRequest<WorkoutInstanceCD>(entityName: "WorkoutInstanceCD")
    }

    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var exerciseInstances: NSOrderedSet

}

// MARK: Generated accessors for exerciseInstances
extension WorkoutInstanceCD {

    @objc(insertObject:inExerciseInstancesAtIndex:)
    @NSManaged public func insertIntoExerciseInstances(_ value: ExerciseInstanceCD, at idx: Int)

    @objc(removeObjectFromExerciseInstancesAtIndex:)
    @NSManaged public func removeFromExerciseInstances(at idx: Int)

    @objc(insertExerciseInstances:atIndexes:)
    @NSManaged public func insertIntoExerciseInstances(_ values: [ExerciseInstanceCD], at indexes: NSIndexSet)

    @objc(removeExerciseInstancesAtIndexes:)
    @NSManaged public func removeFromExerciseInstances(at indexes: NSIndexSet)

    @objc(replaceObjectInExerciseInstancesAtIndex:withObject:)
    @NSManaged public func replaceExerciseInstances(at idx: Int, with value: ExerciseInstanceCD)

    @objc(replaceExerciseInstancesAtIndexes:withExerciseInstances:)
    @NSManaged public func replaceExerciseInstances(at indexes: NSIndexSet, with values: [ExerciseInstanceCD])

    @objc(addExerciseInstancesObject:)
    @NSManaged public func addToExerciseInstances(_ value: ExerciseInstanceCD)

    @objc(removeExerciseInstancesObject:)
    @NSManaged public func removeFromExerciseInstances(_ value: ExerciseInstanceCD)

    @objc(addExerciseInstances:)
    @NSManaged public func addToExerciseInstances(_ values: NSOrderedSet)

    @objc(removeExerciseInstances:)
    @NSManaged public func removeFromExerciseInstances(_ values: NSOrderedSet)

}
