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
    
    var testData : [Double] = [0,1,2,3,4,5,6,7,8,9,10]
    
    let repPickerDelegate = RepPickerDelegate()
    let weightFieldDeleate = WeighFieldDelegate()
    
    
    
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
    }
    
}

class RepPickerDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let reps : [Int] = Array(0...100)

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return reps.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(reps[row])
    }
}

class WeighFieldDelegate : NSObject, UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}
