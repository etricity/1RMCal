//
//  WorkoutViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 28/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    // View Connections
    @IBOutlet weak var workoutLayout: UITableView!
    @IBOutlet weak var history: UITableView!
    
    var workoutManager : WorkoutManager!
    var workout : Workout {
        workoutManager.workout
    }
    // Model Data
    var numCells : Int {
        return workout.instances?.count ?? 0
    }
    lazy var dataSource = WorkoutTableViewDelegate(parentVC: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = workout.name
        
        workoutLayout.delegate = dataSource
        workoutLayout.dataSource = dataSource
        workoutLayout.tableFooterView = UIView()
        
        history.dataSource = self
        history.delegate = self
        history.tableFooterView = UIView()
        
        workoutLayout.allowsSelection = false
    }
    
    
    
    // History Table View Functions
    // TableView functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout.instances?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutHistoryCell", for: indexPath) as! LabelCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // print exercise instances in reverse
        let index = workoutManager.numInstances - 1 - indexPath.row
        print(index)
        if let date = workout.getInstance(index: index)?.date {
            cell.label.text = "\(dateFormatter.string(from: date))"
            
            if let day = date.dayOfWeek() {
                cell.label.text?.append(" (\(day))")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // Delete table cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            workoutManager.removeInstance(index: indexPath.row)
            history.reloadData()
            
            //Erase from core data
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = workoutManager.numInstances - 1 - indexPath.row
        performSegue(withIdentifier: "viewHistory", sender: index)
        
    }
    
    
    @IBAction func performWorkout(_ sender: Any) {
        performSegue(withIdentifier: "performWorkout", sender: nil)
    }
    
    func createInstance(name : String, exerciseInstances : [ExerciseInstance]) {
        // self.exercise is automatically updated when core data is saved
        let workoutInstance = workoutManager.createInstance(name: name, exerciseInstances: exerciseInstances)
        history.reloadData()
    }
    
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        switch segue.identifier {
        case "performWorkout":
            let vc = segue.destination as? WorkoutInstanceViewController 
            vc?.title = self.workout.name
            
            if let exercises = workoutManager.getExercises() {
                vc?.wm = WorkoutInstanceCreator(exercises: exercises)
                vc?.parentVC = self
            }
        case "viewHistory":
            let index = sender as! Int
            let vc = segue.destination as? WorkoutHistoryViewController
            
            if let instance : WorkoutInstance = workoutManager.getInstance(index: index) {
                vc?.wim = WorkoutInstanceManager(workoutInstance: instance)
            }
            break
        default:
            break
        }
    }

}
