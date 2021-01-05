//
//  NewWorkoutViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 23/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class NewWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var exercisesTableView: UITableView!
    @IBOutlet weak var workoutLayout: UITableView!
    
    let modelManager : ExercisesManager = ExercisesManager()
    
    // data for workout creation
    var workoutName : String?
    lazy var exerciseNames : [String] = []
    
    var parentVC : WorkoutsViewController!
    lazy var dataSource = ExerciseTableViewDelegate(parentVC: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Add notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(addExerciseToWorkout(_:)), name: .addExerciseToWorkout, object: nil)
        
        // Table View Delegation & Config
        exercisesTableView.delegate = dataSource
        exercisesTableView.dataSource = dataSource
        exercisesTableView.allowsSelectionDuringEditing = true
        exercisesTableView.tableFooterView = UIView()
        
        workoutLayout.delegate = self
        workoutLayout.dataSource = self
        workoutLayout.dragInteractionEnabled = true
        workoutLayout.allowsSelectionDuringEditing = true
        workoutLayout.tableFooterView = UIView()

    }

    // Workout Layout Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutLayoutCell", for: indexPath) as! LabelCell
        
        if let exerciseName : String = exerciseNames[safe: indexPath.row] {
            cell.label.text = exerciseName
        }
        return cell
   }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let x = sourceIndexPath.row
        let y = destinationIndexPath.row
        if exerciseNames.indices.contains(x) && exerciseNames.indices.contains(y) {
            exerciseNames.swapAt(x, y)
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            if exerciseNames.indices.contains(indexPath.row) {
                exerciseNames.remove(at: indexPath.row)
            }
            
            tableView.reloadData()
        }
     }
    
    // Button Actions
    
    // Finished creating workout (confirm creation)
    @IBAction func confirmNewWorkout(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        if workoutName != nil {
            parentVC.addNewWorkout(name: workoutName!, exercises: exerciseNames)
            parentVC.workoutsTableView.reloadData()
        }
    }
    
    func presentErrorAlert(name : String) {
        let message : String = "Exercise called '\(name)' already exists. Enter a different name."
        let alert = UIAlertController(title: "Exercise Already Exists", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    
    // Add new exercise to exercises model
    @IBAction func newExercise(_ sender: Any) {
        //confirm new exercise
        let alert = UIAlertController(title: "New Exercise", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Exercise Name"
        }
        
        //confirm new exercise
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            // add exercise to tableview
            if let exerciseName = alert.textFields![0].text {
                //add exercise
                // CHECK FOR EXERCISE
                if !self.modelManager.exerciseExists(name: exerciseName) {
                    // update exercise table
                    self.modelManager.addExercise(name: exerciseName)
                    self.exercisesTableView.reloadData()
                } else {
                    self.presentErrorAlert(name: exerciseName)
                }
            }
        } ))
        // cancel action
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        // present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // Add exercise to Workout
    @objc func addExerciseToWorkout(_ notification:Notification) {
        let name = notification.userInfo?["exerciseName"] as! String
        exerciseNames.append(name)
        workoutLayout.reloadData()
    }
    
    // Toggle sorting / viewing mode for workout layout
    @IBOutlet weak var sortButton: UIButton!
    @IBAction func sortExercises(_ sender: Any) {
        if workoutLayout.isEditing {
            workoutLayout.isEditing = false
            sortButton.setTitle("Sort", for: .normal)
            
        } else {
            workoutLayout.isEditing = true
            sortButton.setTitle("Done", for: .normal)
        }
    }
}
