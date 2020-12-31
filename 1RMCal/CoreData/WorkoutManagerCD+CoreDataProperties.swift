//
//  WorkoutManagerCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 31/12/20.
//
//

import Foundation
import CoreData


extension WorkoutManagerCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutManagerCD> {
        return NSFetchRequest<WorkoutManagerCD>(entityName: "WorkoutManagerCD")
    }

    @NSManaged public var workouts: NSSet?

}

// MARK: Generated accessors for workouts
extension WorkoutManagerCD {

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: WorkoutCD)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: WorkoutCD)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSSet)

}
