//
//  SetStatCD+CoreDataProperties.swift
//  
//
//  Created by Isaiah Cuzzupe on 4/1/21.
//
//

import Foundation
import CoreData


extension SetStatCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SetStatCD> {
        return NSFetchRequest<SetStatCD>(entityName: "SetStatCD")
    }

    @NSManaged public var repCount: Double
    @NSManaged public var unitString: String
    @NSManaged public var weight: Double

}
