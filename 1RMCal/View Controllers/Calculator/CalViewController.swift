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
    @IBOutlet weak var bestRM: UILabel!
    @IBOutlet weak var latestRM: UILabel!
    @IBOutlet weak var newRM: UILabel!
    @IBOutlet weak var bestSetRep: UILabel!
    @IBOutlet weak var latestSetRep: UILabel!
    @IBOutlet weak var newSetRep: UILabel!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var measurementControl: UISegmentedControl!
    @IBOutlet weak var repPicker: UIPickerView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var exerciseVC : ExerciseInstanceViewController?
    
    //Settings current & global
    let settings = Settings.shared
    var currentUnits : UnitMass = .kilograms
    lazy var globalUnits = Weight.init(rawValue: settings.getSetting(key: "appWeightUnit") ?? "")
    
    //1RM Values
    let repRange : [Int] = Array(0...100)
    
    var currentReps : Double = 0
    var currentWeight : Measurement = Measurement(value: 0, unit: UnitMass.kilograms)
    

    override func viewDidLoad() {
        super.viewDidLoad()
                
        //Rep picker configuration
        self.repPicker.delegate = self
        self.repPicker.dataSource = self
        
        //Weight field configuarion
        weightField.delegate = self
        weightField.keyboardType = .decimalPad
        weightField.inputAccessoryView = toolBar()
        
        //init view
        configureLabels()
        
    }
    
    //Button actions
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func done(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.createSetStat()
    }
    
    func createSetStat() {
        let cd = CoreDataManager.shared
        let set = cd.createSetStat(weight: self.currentWeight.value, repCount: self.currentReps, unitString: globalUnits.rawValue)
        exerciseVC?.addSet(newSet: set)
        cd.testData()
    }
    
    @IBAction func unitsChanged(_ sender: UISegmentedControl) {
        
        //Change current units (weight being lifted units)
        switch (sender.selectedSegmentIndex) {
        case 0:
            currentUnits = .kilograms
            break
        case 1:
            currentUnits = .pounds
            break
        default:
            currentUnits = .kilograms
            break
    }
        //update 1RM
        updateNew1RM()
}
    
    //Init functions
    func configureLabels() {
        newRM.adjustsFontSizeToFitWidth = true
        latestRM.adjustsFontSizeToFitWidth = true
        bestRM.adjustsFontSizeToFitWidth = true
        
        newRM.text = "0.0"
        latestRM.text = "0.0"
        bestRM.text = "0.0"
    }

    
    // 1 RM Formula
    // This calculation is always done in kg and converted if needed in method updateNew1RM()
    func calculate1RM(weight : Double, reps : Double) -> Double {
        var calculated1RM : Double = 0
        calculated1RM = weight * (1 + (reps/30))
        calculated1RM = calculated1RM.rounded()
        return calculated1RM
    }
    
    func updateNew1RM() {
        //ensure weight is updated to reflect view
        updateWeight()
        //calculate new rm
        var value = calculate1RM(weight: self.currentWeight.value, reps: Double(self.currentReps))
    
        //convert value to global units
        var new1RM = Measurement(value: value, unit: UnitMass.kilograms)
        
        switch globalUnits {
        case .kg:
            new1RM = new1RM.converted(to: .kilograms)
            break
        case .lbs:
            new1RM = new1RM.converted(to: .pounds)
            break
        default:
            break
        }
        
        //update labels
        let text = String(new1RM.value.rounded())
        let weightText = currentWeight.value.round(to: 2)
        
        newRM.text = text
        bestRM.text = text
        latestRM.text = text
        newSetRep.text = "\(weightText) \(globalUnits.rawValue) x \(currentReps)"
    }
    
    // Updates weight to relfect user settings (weight entered & unit slider)
    // Always converted to kg for calculations
    func updateWeight() {
        switch currentUnits {
            case .kilograms:
                self.currentWeight = Measurement(value: weightField.text?.toDouble() ?? 0, unit: UnitMass.kilograms)
                break
            case .pounds:
                self.currentWeight = Measurement(value: weightField.text?.toDouble() ?? 0, unit: UnitMass.pounds)
                self.currentWeight = self.currentWeight.converted(to: .kilograms)
                break
            default:
                self.currentWeight = Measurement(value: weightField.text?.toDouble() ?? 0, unit: UnitMass.kilograms)
        }
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
        currentReps = Double(repRange[row])
        updateNew1RM()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        updateNew1RM()
        return true
      }
}
