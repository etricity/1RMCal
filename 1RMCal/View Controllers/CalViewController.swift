//
//  CalViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 30/11/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class CalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    //View Connections
    @IBOutlet weak var best: UILabel!
    @IBOutlet weak var latest: UILabel!
    @IBOutlet weak var new: UILabel!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var measurementControl: UISegmentedControl!
    @IBOutlet weak var repPicker: UIPickerView!
        

    let settings = Settings.shared
    
    //1RM Values
    let repRange : [Int] = Array(0...100)
    var reps : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Rep picker configuration
        self.repPicker.delegate = self
        self.repPicker.dataSource = self
        
        //Weight field configuarion
        weightField.delegate = self
        weightField.keyboardType = .decimalPad
        weightField.inputAccessoryView = toolBar()
        
        configureLabels()
        
    }
    
    @IBAction func cancel(_ sender: Any) {
    }
    @IBAction func done(_ sender: Any) {
    }
    
    @IBAction func unitsChanged(_ sender: UISegmentedControl) {
        
        var currentWeight : Double = weightField.text?.toDouble() ?? 0
        
        let key = SettingTypes.appWeightUnit.rawValue
        switch(sender.selectedSegmentIndex){
        case 0:
            let units = Weight.kg.rawValue
            settings.updateSetting(key: key , value: units)
            currentWeight /= 2.20462
        case 1:
            let units = Weight.lbs.rawValue
            settings.updateSetting(key: key , value: units)
            currentWeight *= 2.20462
        default:
            break
        }
        
        weightField.text = String(currentWeight)
    }
    
    //Init functions
    func configureLabels() {
        new.adjustsFontSizeToFitWidth = true
        latest.adjustsFontSizeToFitWidth = true
        best.adjustsFontSizeToFitWidth = true
    }
    
    //Calculate 1 RM
    func calculate1RM() -> Double {
        var value : Double = 0
        let weight : Double = weightField.text?.toDouble() ?? 0
        let reps : Double = Double(self.reps)
        
        value = weight * (1 + (reps/30))
        
        //check settings
        let units = Weight.init(rawValue: settings.getSetting(key: SettingTypes.appWeightUnit.rawValue) ?? "")
        
        var convertedUnit = UnitMass.kilograms
        switch units {
        case .kg:
            convertedUnit = UnitMass.kilograms
        case .lbs:
        convertedUnit = UnitMass.pounds
        default:
            convertedUnit = UnitMass.kilograms
        }
        
        var calculated1RM = Measurement(value: value, unit: convertedUnit).value
        
        calculated1RM = calculated1RM.round(to: 2)
        return calculated1RM
    }
    
    func updateNewRM() {
        let new1RM = calculate1RM()
        new.text = String(new1RM)
        best.text = new.text
        latest.text = new.text
    }
}

extension CalViewController {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return repRange.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(repRange[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        reps = repRange[row]
        updateNewRM()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        updateNewRM()
        return true
      }
    
}

