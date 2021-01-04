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
        let numInstances = workoutInstance.exerciseInstances.count
        return workoutInstance.exerciseInstances[numInstances - section - 1].name
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutInstance.exerciseInstances[section].sets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setHistoryCell") as! LabelCell
        let numInstances = workoutInstance.exerciseInstances.count
        let exerciseInstance = workoutInstance.exerciseInstances[numInstances - indexPath.section - 1]
//        cell.label.text = "\(exerciseInstance.sets[indexPath.row].summary)"
        return cell
    }
}
