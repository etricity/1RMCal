//
//  NewWorkoutViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 23/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class NewWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExercisesView {
    
    @IBOutlet weak var exercisesTableView: UITableView!
    @IBOutlet weak var workoutLayout: UITableView!
    
    var workoutsVC : WorkoutsViewController!
    var workout : Workout!
    
    var vm : ExerciseViewModel = ExerciseViewModel()
    lazy var dataSource = ExerciseViewOnlyDelegate(parentVC: self)
    
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
    
    // Confirming addition of new workout
    @IBAction func confirmNewWorkout(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        workoutsVC.addNewWorkout(newWorkout: workout)
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
            if let newExercise = alert.textFields![0].text {
                //add exercise
                if self.vm.addExercise(name: newExercise) {
                    // update exercise table
                    self.exercisesTableView.reloadData()
                } else {
                    print("DUPLICATE")
                }
            }
        } ))
        // cancel action
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        // present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // Workout Layout Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout.exercises.count
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutLayoutCell", for: indexPath) as! LabelCell
        cell.label.text = workout.exercises[indexPath.row].name
        return cell
   }
    
    
    // Add exercise to Workout
    @objc func addExerciseToWorkout(_ notification:Notification) {
        print("working")
        let index = notification.userInfo?["index"] as! Int
        workout.addExercise(exercise: vm.getExercises()[index])
        workoutLayout.reloadData()
    }
    
    
    @IBOutlet weak var sortButton: UIButton!
    // sort & delete exercies
    @IBAction func sortExercises(_ sender: Any) {
        if workoutLayout.isEditing {
            workoutLayout.isEditing = false
            sortButton.setTitle("Sort", for: .normal)
            
        } else {
            workoutLayout.isEditing = true
            sortButton.setTitle("Done", for: .normal)
        }
    }
    
    // Sorting Cells
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        workout.exercises.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    // Deleting cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            workout.exercises.remove(at: indexPath.row)
            tableView.reloadData()
            
            //Erase from Core Data
        }
     }
}
