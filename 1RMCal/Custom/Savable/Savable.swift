//
//  ObjectSavable.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 26/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation

//Implemented by as an extension to allow the saving objects to UserDefaults
protocol ObjectSavable {
    func setSavable<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}
