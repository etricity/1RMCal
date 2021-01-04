//
//  SetStat+CoreDataClass.swift
//
//
//  Created by Isaiah Cuzzupe on 31/12/20.
//
//

import Foundation
import CoreData

@objc(SetStat)
public class SetStat: NSManagedObject {
    
    var units: Weight {
      get {
        return .init(rawValue: self.unitString)
      }
    }
    
    var oneRM : Double {
        var val = self.weight * (1 + (Double(self.repCount)/30))
        val = val.rounded()
        return val
    }
    
    var summary : String {
        return "\(self.oneRM) \(self.units) (\(self.weight) \(self.units) x \(self.repCount))"
    }
    
}
