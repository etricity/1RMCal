//
//  CalViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 30/11/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class CalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    //View Connections
    @IBOutlet weak var best: UILabel!
    @IBOutlet weak var latest: UILabel!
    @IBOutlet weak var new: UILabel!
    
    @IBOutlet weak var measurementControl: UISegmentedControl!
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var repPicker: UIPickerView!
    
    var testData : [Double] = [0,1,2,3,4,5,6,7,8,9,10]
    
    let weightPickerDelegate = WeightPickerDelegate()
    let repPickerDelegate = RepPickerDelegate()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegation
        self.weightPicker.delegate = weightPickerDelegate
        self.weightPicker.dataSource = weightPickerDelegate
        self.repPicker.delegate = repPickerDelegate
        self.repPicker.dataSource = repPickerDelegate
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
    }
    @IBAction func done(_ sender: Any) {
    }
    
}

extension CalViewController {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return testData.count
    }
    
}


class WeightPickerDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let weights = Array(stride(from: 1.0, through: 500.0, by: 0.5))

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weights.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(weights[row])
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
