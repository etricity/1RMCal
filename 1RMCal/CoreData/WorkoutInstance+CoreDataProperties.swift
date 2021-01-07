//
//  WorkoutInstance+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 7/1/21.
//
//

import Foundation
import CoreData


extension WorkoutInstance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutInstance> {
        return NSFetchRequest<WorkoutInstance>(entityName: "WorkoutInstance")
    }

    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var exerciseInstances: NSOrderedSet?
    @NSManaged public var workout: Workout?

}

// MARK: Generated accessors for exerciseInstances
extension WorkoutInstance {

    @objc(insertObject:inExerciseInstancesAtIndex:)
    @NSManaged public func insertIntoExerciseInstances(_ value: ExerciseInstance, at idx: Int)

    @objc(removeObjectFromExerciseInstancesAtIndex:)
    @NSManaged public func removeFromExerciseInstances(at idx: Int)

    @objc(insertExerciseInstances:atIndexes:)
    @NSManaged public func insertIntoExerciseInstances(_ values: [ExerciseInstance], at indexes: NSIndexSet)

    @objc(removeExerciseInstancesAtIndexes:)
    @NSManaged public func removeFromExerciseInstances(at indexes: NSIndexSet)

    @objc(replaceObjectInExerciseInstancesAtIndex:withObject:)
    @NSManaged public func replaceExerciseInstances(at idx: Int, with value: ExerciseInstance)

    @objc(replaceExerciseInstancesAtIndexes:withExerciseInstances:)
    @NSManaged public func replaceExerciseInstances(at indexes: NSIndexSet, with values: [ExerciseInstance])

    @objc(addExerciseInstancesObject:)
    @NSManaged public func addToExerciseInstances(_ value: ExerciseInstance)

    @objc(removeExerciseInstancesObject:)
    @NSManaged public func removeFromExerciseInstances(_ value: ExerciseInstance)

    @objc(addExerciseInstances:)
    @NSManaged public func addToExerciseInstances(_ values: NSOrderedSet)

    @objc(removeExerciseInstances:)
    @NSManaged public func removeFromExerciseInstances(_ values: NSOrderedSet)

}
