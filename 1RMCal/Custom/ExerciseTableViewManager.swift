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

class ExerciseTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var data : [String] = []
    
    var parentVC : UIViewController & ExercisesView
    
    init(data : [Exercise], parentVC : UIViewController & ExercisesView) {
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
        
        // IF on Exercises View Controller, allow editing
        
        if ((parentVC as? ExercisesViewController) != nil) {
            return true
        } else if ((parentVC as? NewWorkoutViewController) != nil) {
            return false
        }
        return false
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // For Exercise View Controler only
        if (editingStyle == .delete) && ((parentVC as? ExercisesViewController) != nil) {
            // handle delete (by removing the data from your array and updating the tableview)
            parentVC.vm.removeExercise(index: indexPath.row)
            tableView.reloadData()
            
            //Erase from Core Data
        }
    }


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // For NewWorkoutController only 
        if ((parentVC as? NewWorkoutViewController) != nil) {
            let selectedCell = tableView.cellForRow(at: indexPath) as! LabelCell
            
            // add exercise to workout layout
            if selectedCell.selectionStyle != .none {
                selectedCell.label.textColor = .gray
                selectedCell.selectionStyle = .none
                let data : [String : Int] = ["index" : indexPath.row]
                NotificationCenter.default.post(name: .addExerciseToWorkout, object: nil, userInfo: data)
            }
        }
    }

}
