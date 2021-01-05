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

class ExercisesViewController: UITableViewController, UIActionSheetDelegate {
    
    @IBOutlet var exercisesTableView: UITableView!
    
    // Model Manager
    let modelManager = AllExercisesManager()
    
    // Number of cells for exercise table view
    var numCells : Int {
        guard let numCells = modelManager.exercises?.count else {return 0}
        return numCells
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Exercise Table View delegation & config
        exercisesTableView.delegate = self
        exercisesTableView.dataSource = self
        
        exercisesTableView.allowsSelectionDuringEditing = true
        exercisesTableView.tableFooterView = UIView()
    }
    
    func addExercise(name : String) {
        self.modelManager.addExercise(name: name)
        NotificationCenter.default.post(name: .saveData, object: nil, userInfo: nil)
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
                if !self.modelManager.exerciseExists(name: newExercise) {
                    //reload able
                    self.addExercise(name: newExercise)
                    self.exercisesTableView.reloadData()
                }
            }
        } ))
        // cancel action
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        // present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    // Tabke View Data Source & Delegate Functions
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
        
        if let exercise = modelManager.getExercise(index: indexPath.row) {
            cell.label.text = exercise.name
        }
        return cell
    }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            modelManager.removeExercise(index: indexPath.row)
            tableView.reloadData()
        }
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        performSegue(withIdentifier: "goToExercise", sender: index)
        
    }
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        switch segue.identifier {
        case "goToExercise":
            let index = sender as! Int
            let vc = segue.destination as? ExerciseViewController
            if let exercise = modelManager.getExercise(index: index) {
                vc?.exerciseManager = ExerciseManager(exercise: exercise)
            }
        default:
            break

        }
    }
}
