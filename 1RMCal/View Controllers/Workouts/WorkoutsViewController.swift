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
    var vm : WorkoutViewModel = WorkoutViewModel()
    var numCells : Int {
        return vm.getWorkouts().count
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

        cell.label.text = vm.getWorkouts()[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            vm.removeWorkout(index: indexPath.row)
            workoutsTableView.reloadData()
            
            //Erase from Core Data
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        performSegue(withIdentifier: "goToWorkout", sender: index)
        
    }
    
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
    
    func addNewWorkout(newWorkout : Workout) {
        if self.vm.addWorkout(workout: newWorkout) {
            //reload able
            self.workoutsTableView.reloadData()
        }
    }
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        switch segue.identifier {
            case "newWorkout":
                let workoutName = sender as! String
                let vc = segue.destination as? NewWorkoutViewController
                vc?.workout = Workout(name: workoutName)
                vc?.title = workoutName
                vc?.workoutsVC = self
            case "goToWorkout":
                let vc = segue.destination as? WorkoutViewController
            default:
                break
        }
    }
}
