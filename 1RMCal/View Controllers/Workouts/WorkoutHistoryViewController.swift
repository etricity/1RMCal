//
//  WorkoutHistoryViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 29/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class WorkoutHistoryViewController: UITableViewController {
    
    // Workout Instance the history data comes from
    var workoutInstance : WorkoutInstance!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }
    
    // Table View Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return workoutInstance.exerciseInstances.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return workoutInstance.exerciseInstances[section].name
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutInstance.exerciseInstances[section].sets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setHistoryCell") as! LabelCell  
        let exerciseInstance = workoutInstance.exerciseInstances[indexPath.section]
        cell.label.text = "\(exerciseInstance.sets[indexPath.row].summary)"
        return cell
    }
}
