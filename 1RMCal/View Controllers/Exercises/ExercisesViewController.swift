//
//  ExercisesViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 13/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

// The ExercisesViewController acts as the delegate & data source for Exercise Table View on the Exercise Page
/*
 Allows for:
    - viewing exercises
    - adding to exercises
    - deleting exercises
 */

class ExercisesViewController: UITableViewController, ExercisesView, UIActionSheetDelegate {
    
    @IBOutlet var exercisesTableView: UITableView!
    
    // View Model
    var vm : ExerciseViewModel = ExerciseViewModel()
    lazy var dataSource = ExerciseTableViewManager(data: vm.getExercises(), parentVC: self)
    
    // Number of cells for exercise table view
    var numCells : Int {
        return vm.getExercises().count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Exercise Table View delegation & config
        exercisesTableView.delegate = dataSource
        exercisesTableView.dataSource = dataSource
        
        exercisesTableView.allowsSelectionDuringEditing = true
        exercisesTableView.tableFooterView = UIView()
    }
    
    
    //Adding new exercise to table view
    @IBAction func addExercise(_ sender: Any) {
        // Alert configuration
        let alert = UIAlertController(title: "New Exercise", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Exercise Name"
        }
        
        //confirm new exercise
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            // add exercise to tableview
            if let newExercise = alert.textFields![0].text {
                //add exercise if no duplicate name found
                if self.vm.addExercise(name: newExercise) {
                    //reload able
                    self.exercisesTableView.reloadData()
                }
            }
        } ))
        // cancel action
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        // present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    // Table View Data Source & Delegate Functions
     override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numCells
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! LabelCell
        cell.label.text = vm.getExercises()[indexPath.row].name
        return cell
    }
    
    // Delete cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            vm.removeExercise(index: indexPath.row)
            tableView.reloadData()
            //Erase from Core Data
        }
     }
    
    // Segue Function to go from Exercises -> Exercise
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let  exercise = sender as? LabelCell {
            if segue.destination is ExerciseViewController
            {
                let vc = segue.destination as? ExerciseViewController
                vc?.exercise = vm.getExercise(name: exercise.label.text!)
            }
        }
    }
}
