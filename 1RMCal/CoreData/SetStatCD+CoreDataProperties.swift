//
//  SetStatCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 31/12/20.
//
//

import Foundation
import CoreData


extension SetStatCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SetStatCD> {
        return NSFetchRequest<SetStatCD>(entityName: "SetStatCD")
    }

    @NSManaged public var oneRM: Double
    @NSManaged public var repCount: Int16
    @NSManaged public var summary: String?
    @NSManaged public var units: String?
    @NSManaged public var weight: Double

}
