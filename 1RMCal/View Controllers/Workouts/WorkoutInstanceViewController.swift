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
    var wm : WorkoutInstanceCreator!
    var exercises : [Exercise] {
        return wm.exercises
    }
    var modifyingInstance : Bool {wm.modifyingInstance != nil}
    var parentVC : WorkoutViewController!
    
    // Data for workout instance creation
    var workoutName : String?
    var exerciseInstances : [ExerciseInstance] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        if let workoutName : String = self.title {
            self.workoutName = workoutName
        }
        
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
        
        let index = indexPath.row
        let selectedCell = tableView.cellForRow(at: indexPath) as! LabelCell
        // IF cell has not been selected
        if selectedCell.label.textColor != .gray {
            // update cell style
            selectedCell.label.textColor = .gray
            // perform exercise
            wm.setCurrentExercise(index: index)
            wm.modifyingInstance = nil
            performSegue(withIdentifier: "performExercise", sender: index)
        
            // modifying exercise
        } else {
            if let modifyingExInstance = exerciseInstances.filter({ $0.name == selectedCell.label.text }).first {
                wm.modifyingInstance = modifyingExInstance
                wm.setCurrentExercise(index: index)
                performSegue(withIdentifier: "performExercise", sender: index)
            }
            
            
        }
    }
    
    func createInstance(sets: [SetStat]) {
        // create exercise instance
        let instance = wm.createInstance(sets: sets)
        exerciseInstances.append(instance)
    }
        
    @IBAction func finishWorkout(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        if let name : String = workoutName, exerciseInstances.count > 0 {
            parentVC.createInstance(name: name, exerciseInstances: exerciseInstances)
        }
    }
    
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let vc = segue.destination as? ExerciseInstanceViewController
        let index = sender as! Int
        vc?.title = wm.currentExercise?.name
        vc?.bestSetText = wm.currentExercise?.bestSet?.summary ?? "N/A"
        vc?.parentVC = self
        
        if modifyingInstance {
            vc?.setsManager = SetStatManager(sets: wm.modifyingInstance?.sets.array as? [SetStat] ?? [])
            vc?.modifyingExistingInstance = true
        } else {
            vc?.setsManager = SetStatManager()
            vc?.modifyingExistingInstance = false
        }
    }
}
