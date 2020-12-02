//
//  Settings.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 24/9/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation


/*
    This is a singleton class created to interact with UserDefaults and implement user settings for our app.
    Having this class allows use to fully control how UserDefaults interacts with our app.
 */

class Settings {
    
    static let shared = Settings()
    
    //Default settings
    var defaultWeightUnit : UnitMass = .kilograms
    
    //Provide default settings if no settings are previously found
    private init(){
        var key = "appWeightUnit"
        if !isKeyPresentInUserDefaults(key: key) {
            UserDefaults.standard.set(Weight.kg.rawValue, forKey: key)
        }

}
    //Checks if a key has a value in UserDefaults
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    //Update a string UserDefault key/value
    func updateSetting(key : String, value : Any) {
         UserDefaults.standard.set(value, forKey: key)
    }
    
    //Update a setting object (generics)
    func updateSetting<T : Encodable>(key : String, object : T) {
         do {
            try UserDefaults.standard.setSavable(object, forKey: key)
            
         } catch {
            print(error)
            
        }
    }
    
    //Get a string value from UserDefaults
    func getSetting(key : String) -> String? {
        let setting : String? = UserDefaults.standard.object(forKey: key) as? String
        return setting
    }
    
    //Get a double value from UserDefaults
    func getSettingDouble(key : String) -> Double? {
        let setting : Double? = UserDefaults.standard.double(forKey: key)
        return setting
    }
    
    //Get a  object from UserDefaults
//    func getCity(key : CityType) -> City? {
//
//        var city : City?
//        do {
//            city = try UserDefaults.standard.getObject(forKey: key.rawValue, castTo: City.self)
//
//        } catch {
//            print(error.localizedDescription)
//        }
//        return city
//    }
        
    //Reset all neccessary settings to their default values
    func reset() {
    }
}

enum SettingTypes : String {
    case appWeightUnit
}
