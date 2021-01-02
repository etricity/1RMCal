//
//  WorkoutInstanceViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 29/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class WorkoutInstanceViewController: UITableViewController, ExerciseInstanceCreator {

    var parentVC : WorkoutViewController!
    lazy var instance : WorkoutInstanceCD = CoreDataManager.shared.createWorkoutInstance(name: parentVC.workoutCD.name)
    var currentExerciseIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    // Table View Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return parentVC.workoutCD.exercises.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)  as! LabelCell

        if let exercise = parentVC.workoutCD.getExercise(index: indexPath.row) {
            cell.label.text = exercise.name
        }
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
            currentExerciseIndex = index
            performSegue(withIdentifier: "performExercise", sender: index)
            
        }
    }
    
    // called from ExerciseInstanceController
    func addInstance(newInstance: ExerciseInstance) {
//        parentVC.workout.exercises[currentExerciseIndex].addInstance(newInstance: newInstance)
//        workoutInstance.addInstance(newInstance: newInstance)
    }
    
    @IBAction func finishWorkout(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        parentVC.workoutCD.addInstance(instance: instance)
    }
    
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let vc = segue.destination as? ExerciseInstanceViewController
        let index = sender as! Int
        
        if let exercise = parentVC.workoutCD.getExercise(index: index) {
            vc?.title = exercise.name
            vc?.bestSetText = exercise.bestSet?.summary ?? "N/A"
//            vc?.exerciseInstance = ExerciseInstance(name: exercise.name)
            vc?.parentVC = self
        }
    }
}
