//
//  WorkoutViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 23/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class WorkoutsViewController: UITableViewController {
    
    @IBOutlet var workoutsTableView: UITableView!
    // View Model
    // Model Manager
    let workoutManager = WorkoutsManager()
    
    // Number of cells for exercise table view
    var numCells : Int {
        guard let numCells = workoutManager.workouts?.count else {return 0}
        return numCells
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Workouts"
        workoutsTableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numCells
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath)  as! LabelCell
        
        if let workout = workoutManager.getWorkout(index: indexPath.row) {
            cell.label.text = workout.name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            workoutManager.removeWorkout(index: indexPath.row)
            workoutsTableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        // Go to clicked workout
        performSegue(withIdentifier: "goToWorkout", sender: index)
        
    }
    
    
    func presentErrorAlert(name : String) {
        let message : String = "Workout called '\(name)' already exists. Enter a different name."
        let alert = UIAlertController(title: "Workout Already Exists", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    // Create new Exercise
    @IBAction func newWorkout(_ sender: Any) {
        //confirm new exercise
        let alert = UIAlertController(title: "New Workout", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Workout Name"
        }


        //confirm new exercise
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            // add exercise to tableview
            if let newWorkout = alert.textFields![0].text {
                //perform segue
                
                if !self.workoutManager.workoutExists(name: newWorkout) {
                    self.performSegue(withIdentifier: "newWorkout", sender: newWorkout) //executing the segue on cancel
                } else {
                    self.presentErrorAlert(name: newWorkout)
                }
            }
        } ))
        // cancel action
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        // present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // confirming new exercise in "New Exercise Alert"
    func addNewWorkout(name : String, exercises : [String]) {
        workoutManager.addWorkout(name: name, exercises: exercises)
    }
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        switch segue.identifier {
            // Creating new workout
            case "newWorkout":
                let workoutName = sender as! String
                let vc = segue.destination as? NewWorkoutViewController
                vc?.workoutName = workoutName
                vc?.title = workoutName
                vc?.parentVC = self
            // Going to existing workout
            case "goToWorkout":
                let index = sender as! Int
                let vc = segue.destination as? WorkoutViewController
                if let workout = workoutManager.getWorkout(index: index) {
                    vc?.workoutManager = WorkoutManager(workout: workout)
                }
            default:
                break
        }
    }
}
