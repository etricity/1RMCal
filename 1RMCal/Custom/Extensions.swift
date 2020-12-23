//
//  Extensions.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 2/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    //Tool bar for calculator decimal pad
    func toolBar() -> UIToolbar{
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5) //Write what you want for color
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let buttonTitle = "Done"
        let doneButton = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(onClickDoneButton))
        doneButton.tintColor = .white
        toolBar.setItems([space, doneButton, space], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }
    
    //action for toolbar "done" button
    @objc func onClickDoneButton(){
        view.endEditing(true)
    }
}

extension String {
    //String to Double
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
        
    }
}

extension Double {
    //round double to x decimal places
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


//The extensions to UserDefaults allows the saving of objects. It is used to save city objects (currentCity, weatherCity)
extension UserDefaults: ObjectSavable {
    //Save object in UserDefaults
    func setSavable<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    //Get saved object from UserDefaults
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}

//Error descriptions for saving objects in UserDefaults
enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        return self.rawValue
    }
}

extension Notification.Name {
    static let addExerciseToWorkout = Notification.Name("addExerciseToWorkout")
}
