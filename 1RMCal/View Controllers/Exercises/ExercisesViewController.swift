//
//  ExercisesViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 13/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class ExercisesViewController: UITableViewController, UIActionSheetDelegate {
    
    // View Model
    var vm : ExerciseViewModel = ExerciseViewModel()
    
    var exercises : [String] = ["Bench Press", "Squat", "Deadlift"]
    var numCells : Int {
        return vm.getExercises().count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
                //add exercise
                if self.vm.addExercise(name: newExercise) {
                    self.tableView.reloadData()
                } else {
                    print("DUPLICATE")
                }
            }
        } ))
        
        // cancel action
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! ExerciseTableViewCell
        
        cell.label.text = vm.getExercises()[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            vm.removeExercise(index: indexPath.row)
            tableView.reloadData()
            
            //Erase from Core Data
        }
    }
    
    //Segue Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if let  exercise = sender as? ExerciseTableViewCell {
            if segue.destination is ExerciseViewController
            {
                let vc = segue.destination as? ExerciseViewController
                vc?.title = exercise.label.text
            }
        }

    }

}
