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
    var wm : WorkoutInstanceManager = WorkoutInstanceManager(exercises: CoreDataManager.shared.getExercises() ?? [])
    var exercises : [Exercise] {
        return wm.exercises
    }
    
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
        let instance = wm.createInstance(name: name, sets: sets)
    }

    
    @IBAction func finishWorkout(_ sender: Any) {
        navigationController?.popViewController(animated: true)
//        parentVC.addWorkoutInstance(newInstance: workoutInstance)
    }
    
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let vc = segue.destination as? ExerciseInstanceViewController
    }
}
