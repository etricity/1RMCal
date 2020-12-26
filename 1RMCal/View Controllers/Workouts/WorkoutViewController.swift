//
//  WorkoutViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 26/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {

    var workout : Workout!
    
    // View Connections
    @IBOutlet weak var exerciesTableView: UITableView!
    @IBOutlet weak var workoutHistory: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
