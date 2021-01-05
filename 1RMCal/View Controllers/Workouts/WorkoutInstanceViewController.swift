//
//  WorkoutInstanceViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 29/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class WorkoutInstanceViewController: UITableViewController, ExerciseInstanceCreator {
   
    // change later
    var wm : WorkoutInstanceCreator!
    var exercises : [Exercise] {
        return wm.exercises
    }
    var parentVC : WorkoutViewController!
    
    // Data for workout instance creation
    var workoutName : String?
    var exerciseInstances : [ExerciseInstance] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        if let workoutName : String = self.title {
            self.workoutName = workoutName
        }
        
    }
    
    // Table View Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wm.exercises.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)  as! LabelCell

        cell.label.text = wm.getExercise(index: indexPath.row)?.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! LabelCell
        // IF cell has not been selected
        if selectedCell.selectionStyle != .none {
            // disable cell
            selectedCell.label.textColor = .gray
            selectedCell.selectionStyle = .none
            
            // perform exercise
            let index = indexPath.row
            wm.setCurrentExercise(index: index)
            performSegue(withIdentifier: "performExercise", sender: index)
            
        }
    }
    
    func createInstance(name: String, sets: [SetStat]) {
        // create exercise instance
        let instance = wm.createInstance(name: name, sets: sets)
        exerciseInstances.append(instance)
    }

    
    @IBAction func finishWorkout(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        if let name : String = workoutName, exerciseInstances.count > 0 {
            parentVC.createInstance(name: name, exerciseInstances: exerciseInstances)
        }
    }
    
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let vc = segue.destination as? ExerciseInstanceViewController
        let index = sender as! Int
        vc?.title = wm.getExercise(index: index)?.name
        vc?.bestSetText = wm.getExercise(index: index)?.bestSet?.summary ?? "N/A"
        vc?.parentVC = self
        vc?.setsManager = SetStatManager()
    }
}
