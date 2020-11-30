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
    
    @IBOutlet weak var measurementControl: UISegmentedControl!
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var repPicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
    }
    @IBAction func done(_ sender: Any) {
    }
    
}
