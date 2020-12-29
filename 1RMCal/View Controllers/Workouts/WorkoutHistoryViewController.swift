//
//  WorkoutHistoryViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 29/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class WorkoutHistoryViewController: UITableViewController {
    
    var workout : Workout!
    var workoutInstance : WorkoutInstance!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return workout.exercises.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return workout.exercises[section].name
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var val : Int = 0
        if workoutInstance.exerciseInstances.indices.contains(section) {
            val = workoutInstance.exerciseInstances[section].sets.count
        }
        return val
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setHistoryCell") as! LabelCell
        
        cell.label.text = "\(workoutInstance.exerciseInstances[indexPath.section].sets[indexPath.row].summary)"

        return cell
    }
}
