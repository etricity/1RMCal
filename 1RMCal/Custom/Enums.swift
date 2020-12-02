//
//  Enums.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 2/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import Foundation

enum Weight : String {
    
    case kg, lbs
    
    init(rawValue: String){
        
        switch rawValue {
        case "kg":
            self = .kg
            break
        case "lbs":
            self = .lbs
            break
        default:
            self = .kg
            break
        }
    }
}
