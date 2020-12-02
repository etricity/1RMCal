//
//  CalViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 30/11/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class CalViewController: UIViewController {
    
    //View Connections
    @IBOutlet weak var best: UILabel!
    @IBOutlet weak var latest: UILabel!
    @IBOutlet weak var new: UILabel!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var measurementControl: UISegmentedControl!
    @IBOutlet weak var repPicker: UIPickerView!
        
    let repPickerDelegate = RepPickerDelegate()
    let weightFieldDeleate = WeighFieldDelegate()
    
    
    //1RM Values
    var weight : Double = 0
    var reps : Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Rep picker configuration
        self.repPicker.delegate = repPickerDelegate
        self.repPicker.dataSource = repPickerDelegate
        
        //Weight field configuarion
        weightField.delegate = weightFieldDeleate
        weightField.keyboardType = .decimalPad
        weightField.inputAccessoryView = toolBar()
        
    }
    
    @IBAction func cancel(_ sender: Any) {
    }
    @IBAction func done(_ sender: Any) {
        let new1RM = calculate1RM()
        new.text = String(new1RM)
    }
    
    //Calculate 1 RM
    func calculate1RM() -> Double {
        var calculated1RM : Double = 0
        let weight : Double = weightField.text?.toDouble() ?? 0
        let reps : Double = Double(repPickerDelegate.reps)
        
        calculated1RM = weight * (1 + (reps/30))
        return calculated1RM
    }
    
}

class RepPickerDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let repRange : [Int] = Array(0...100)
    var reps : Int = 0

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
    }
}

class WeighFieldDelegate : NSObject, UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
}
