//
//  ExerciseManagerCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 31/12/20.
//
//

import Foundation
import CoreData


extension ExerciseManagerCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseManagerCD> {
        return NSFetchRequest<ExerciseManagerCD>(entityName: "ExerciseManagerCD")
    }

    @NSManaged public var name: String?
    @NSManaged public var exercises: NSOrderedSet?

}

// MARK: Generated accessors for exercises
extension ExerciseManagerCD {

    @objc(insertObject:inExercisesAtIndex:)
    @NSManaged public func insertIntoExercises(_ value: ExerciseCD, at idx: Int)

    @objc(removeObjectFromExercisesAtIndex:)
    @NSManaged public func removeFromExercises(at idx: Int)

    @objc(insertExercises:atIndexes:)
    @NSManaged public func insertIntoExercises(_ values: [ExerciseCD], at indexes: NSIndexSet)

    @objc(removeExercisesAtIndexes:)
    @NSManaged public func removeFromExercises(at indexes: NSIndexSet)

    @objc(replaceObjectInExercisesAtIndex:withObject:)
    @NSManaged public func replaceExercises(at idx: Int, with value: ExerciseCD)

    @objc(replaceExercisesAtIndexes:withExercises:)
    @NSManaged public func replaceExercises(at indexes: NSIndexSet, with values: [ExerciseCD])

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: ExerciseCD)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: ExerciseCD)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSOrderedSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSOrderedSet)

}
