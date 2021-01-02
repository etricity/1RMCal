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
    var numCells : Int {
        guard let workouts = modelManager.workouts else { return 0 }
        return workouts.count
    }
    
    let modelManager = ModelManager()
    lazy var data : [WorkoutCD]? = modelManager.workouts

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
        
        if let workout = modelManager.getWorkout(index: indexPath.row) {
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
            modelManager.removeWorkout(index: indexPath.row)
            workoutsTableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        // Go to clicked workout
        performSegue(withIdentifier: "goToWorkout", sender: index)
        
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
                self.performSegue(withIdentifier: "newWorkout", sender: newWorkout) //executing the segue on cancel
            }
        } ))
        // cancel action
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        // present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // confirming new exercise in "New Exercise Alert"
    func addNewWorkout(name : String) {
        if modelManager.addWorkout(name: name) {
            //reload table
            self.workoutsTableView.reloadData()
        }
    }
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        switch segue.identifier {
            // Creating new workout
            case "newWorkout":
                let workoutName = sender as! String
                let vc = segue.destination as? NewWorkoutViewController
                vc?.workout = Workout(name: workoutName)
                vc?.title = workoutName
                vc?.workoutsVC = self
            // Going to existing workout
            case "goToWorkout":
                let index = sender as! Int
                let vc = segue.destination as? WorkoutViewController
                vc?.workout = Workout(name: "test")
                vc?.workoutCD = modelManager.getWorkout(index: index)
            default:
                break
        }
    }
}
