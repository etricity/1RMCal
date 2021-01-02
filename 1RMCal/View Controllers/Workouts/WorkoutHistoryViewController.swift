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
    var instance : WorkoutInstanceCD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }
    
    // Table View Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return instance.exerciseInstances.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var exerciseName : String? = nil
        
        let numInstances = instance.exerciseInstances.count
        if let exerciseInstance = instance.getExerciseInstance(index: numInstances - section - 1) {
            exerciseName = exerciseInstance.name
        }
        return exerciseName
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numSets : Int = 0
        if let exerciseInstance = instance.getExerciseInstance(index: section) {
            numSets = exerciseInstance.sets.count
        }
        return numSets
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setHistoryCell") as! LabelCell
        let numInstances = instance.exerciseInstances.count
        
        guard let exerciseInstance = instance.getExerciseInstance(index: numInstances - indexPath.section - 1) else {return cell}
        guard let set = exerciseInstance.getSet(index: indexPath.row) else {return cell}
        cell.label.text = set.summary
        return cell
    }
}
