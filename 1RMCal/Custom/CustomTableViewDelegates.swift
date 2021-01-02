//
//  ExerciseTVDelegate.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 23/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

// The ExerciseTableViewManager acts as the delegate & data source for Exercise Table View on the workout creation page
/*
 Allows for:
    - viewing exercises
    - adding to exercises
    - deleting exercises
 
 Functionality coded for 2 classes using if statements for small vairations in functionality:
    - New Workout View Controller
    - Exercise View Controller
 
 */


class ExerciseTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
        
    // This will be either a NewWorkoutController or a ExercisesController
    var parentVC : UIViewController & ExercisesView
    
    init(parentVC : UIViewController & ExercisesView) {
        self.parentVC = parentVC
    }
    
    var numCells : Int {
        return parentVC.vm.getExercises().count
    }
    
    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numCells
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! LabelCell
        cell.label.text = parentVC.vm.getExercises()[indexPath.row].name
        return cell
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return false
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        // Editing enabled for Exercise View Controler only
        if (editingStyle == .delete) && ((parentVC as? ExercisesViewController) != nil) {
            // handle delete (by removing the data from your array and updating the tableview)
            parentVC.vm.removeExercise(index: indexPath.row)
            tableView.reloadData()
        }
    }


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Disabling cells for NewWorkoutController only
    
            let selectedCell = tableView.cellForRow(at: indexPath) as! LabelCell
            
            // add exercise to workout layout & disable cell
            if selectedCell.selectionStyle != .none {
                selectedCell.label.textColor = .gray
                selectedCell.selectionStyle = .none
                let data : [String : Int] = ["index" : indexPath.row]
                NotificationCenter.default.post(name: .addExerciseToWorkout, object: nil, userInfo: data)
            }
    }

}

class WorkoutTableViewDelegate : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    
    var parentVC : WorkoutViewController
    var numCells : Int {
        return parentVC.workoutCD.exercises.count
    }
    

    
    init(parentVC : WorkoutViewController) {
        self.parentVC = parentVC
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! LabelCell
        
        if let exercise = parentVC.workoutCD.getExercise(index: indexPath.row) {
            cell.label.text = exercise.name
        }
        return cell
    }
    
    
}
