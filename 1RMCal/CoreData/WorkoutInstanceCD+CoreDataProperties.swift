//
//  WorkoutInstanceCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 4/1/21.
//
//

import Foundation
import CoreData


extension WorkoutInstanceCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutInstanceCD> {
        return NSFetchRequest<WorkoutInstanceCD>(entityName: "WorkoutInstanceCD")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var exerciseInstances: [NSString]

}
