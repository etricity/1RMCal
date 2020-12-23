//
//  NewWorkoutViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 23/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class NewWorkoutViewController: UIViewController {

    @IBOutlet weak var exercisesTableView: UITableView!
    @IBOutlet weak var workoutLayout: UITableView!
    
    var dataSource = ExerciseTVDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exercisesTableView.dataSource = dataSource
        exercisesTableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
}
