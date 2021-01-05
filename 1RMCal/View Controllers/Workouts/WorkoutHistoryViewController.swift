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
    var wim : WorkoutInstanceManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }
    
    // Table View Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        // num of exercises
        return wim.numExercises
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // exercise name
        return wim.getExerciseInstance(index: section)?.name
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // num of sets
        return wim.getInstanceSets(index: section)?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set name
        let cell = tableView.dequeueReusableCell(withIdentifier: "setHistoryCell") as! LabelCell
        
        
        if let set = wim.getInstanceSet(instanceIndex: indexPath.section, setIndex: indexPath.row) {
            cell.label.text = set.summary
        }
        return cell
    }
}
