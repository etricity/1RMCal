//
//  WorkoutInstance+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 5/1/21.
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
    @NSManaged public var exerciseInstances: NSMutableSet
    @NSManaged public var workout: WorkoutCD?

}

// MARK: Generated accessors for exerciseInstances
extension WorkoutInstance {

    @objc(addExerciseInstancesObject:)
    @NSManaged public func addToExerciseInstances(_ value: ExerciseInstance)

    @objc(removeExerciseInstancesObject:)
    @NSManaged public func removeFromExerciseInstances(_ value: ExerciseInstance)

    @objc(addExerciseInstances:)
    @NSManaged public func addToExerciseInstances(_ values: NSSet)

    @objc(removeExerciseInstances:)
    @NSManaged public func removeFromExerciseInstances(_ values: NSSet)

}
